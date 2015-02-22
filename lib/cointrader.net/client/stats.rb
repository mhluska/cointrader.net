module Cointrader
  module Stats
    def symbol
      request(:get, '/stats/symbol')
    end

    def stats_24h params={}
      currency_pair = params[:currency_pair] || 'BTCUSD'
      request(:get, "/stats/daily/#{currency_pair}")
    end

    def stats_7d params={}
      currency_pair = params[:currency_pair] || 'BTCUSD'
      request(:get, "/stats/weekly/#{currency_pair}")
    end
  end
end
