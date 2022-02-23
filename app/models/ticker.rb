# frozen_string_literal: true

class Ticker < ApplicationRecord
  validates_uniqueness_of :symbol, message: 'you are already tracking this ticker'
  validates_presence_of :symbol

  before_save -> { symbol.upcase! }

  after_update_commit -> { broadcast_replace_to :tickers }
  after_create_commit :fetch_it

  # fetch the price from the API and store it.
  def fetch!
    stock = client.stock(symbol: symbol)

    if $real_data 
      quote = stock.quote
      quote_h = quote.to_h.except(:output)
    else
      quote_h = stock.except(:name, :exchange, :market_cap, :country, :ipo_year, :sector, :industry, :total_stock)
      # replace net_change with change 
      quote_h[:change] = quote_h.delete(:net_change)
      quote_h[:change_percent] = quote_h.delete(:percent_change)
    end

    quote_h.merge!({ last_fetch_at: Time.now.utc })

    update(quote_h)
  end

  # Same as fetch! but skips if last update was less than a minute ago
  def fetch
    return self if last_fetch_at.present? && (Time.now.utc - last_fetch_at < 1.minute)

    fetch!
  end

  def ready?
    change.present?
  end

  def self.generate_random
    ::Ticker.create(symbol: 'AAPL')
    ::Ticker.create(symbol: 'TSLA')
    ::Ticker.create(symbol: 'UAL')
    ::Ticker.create(symbol: 'MSFT')
  end

  private

  def client
    @client ||= if $real_data
                  ::Alphavantage::Client.new(key: $vantage_api_key)
                else
                  ::MarketInfo::Client.new
                end
  end

  def fetch_it
    TickerJob.perform_later self
  end
end
