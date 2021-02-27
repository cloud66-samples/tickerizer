# frozen_string_literal: true
class Ticker < ApplicationRecord
  validates_uniqueness_of :symbol, message: 'you are already tracking this ticker'
  validates_presence_of :symbol

  before_save -> { self.symbol.upcase! }

  after_update_commit  -> { broadcast_replace_to :tickers }
  after_create_commit :fetch_it

  # fetch the price from the API and store it.
  def fetch!
    stock = client.stock symbol: self.symbol
    quote = stock.quote

    quote_h = quote.to_h.except(:output)
    quote_h.merge!({ last_fetch_at: Time.now.utc })

    self.update(quote_h)
  end

  # Same as fetch! but skips if last update was less than a minute ago
  def fetch
    return self if last_fetch_at.present? && (Time.now.utc - self.last_fetch_at < 1.minute)
    fetch!
  end

  def ready?
    self.change.present?
  end

  private

  def client
    @client ||= ::Alphavantage::Client.new key: Rails.application.credentials.alpha_vantage[:api_key]
  end

  def fetch_it
    TickerJob.perform_later self
  end

end