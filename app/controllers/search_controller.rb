class SearchController < ApplicationController
  def documents
    render json: symbols
  end

  private

  def symbols
    if @symbols.nil?
      @symbols = []
      $symbols.values.each_with_index do |symbol, index|
        @symbols << {
          symbol: symbol['symbol'],
          name: symbol['name'],
          country: symbol['country'],
          sector: symbol['sector'],
          industry: symbol['industry'],
          id: index
        }
      end
      @symbols
    else
      @symbols
    end
  end
end
