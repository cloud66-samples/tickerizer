# frozen_string_literal: true

module MarketInfo
  class Client
    include HTTParty
    base_uri 'test.marketinfo.dev'

    def exchanges
      self.class.get('/exchanges').parsed_response.symbolize_keys
    end

    def tickers
      self.class.get('/tickers').parsed_response.symbolize_keys
    end

    def stock(symbol:)
      self.class.get("/tickers/#{symbol}").parsed_response.symbolize_keys
    end
  end
end
