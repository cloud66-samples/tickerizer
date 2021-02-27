module TickerViewer
  class Component < ViewComponent::Base
    attr_reader :ticker

    def initialize(ticker:)
      @ticker = ticker
    end

    def change_color
      value = ticker.change
      if value < 0
        return 'red'
      else
        return 'green'
      end
    end

    # negative numbers have a - sign but positive ones don't
    def change_value(attribute)
      value = ticker.send(attribute)
      if value > 0
        return "+#{value}"
      else
        return value
      end
    end

  end
end