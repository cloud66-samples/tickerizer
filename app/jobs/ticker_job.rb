class TickerJob < ActiveJob::Base
  queue_as :default

  def perform(ticker)
    ticker.fetch
  end

end