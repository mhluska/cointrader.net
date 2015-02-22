module Cointrader
  module Stats
    def symbol
      request(:get, '/stats/symbol')
    end
  end
end
