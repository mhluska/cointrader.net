module Cointrader
  module Stats
    def symbol
      request(:get, '/stats/symbol')
    end

    def stats_24h params={}
      params = get_defaults(params)
      request(:get, "/stats/daily/#{params[:currency_pair]}")
    end

    def stats_7d params={}
      params = get_defaults(params)
      request(:get, "/stats/weekly/#{params[:currency_pair]}")
    end

    # Returns open orders.
    # currency_pair - 6 character currency pair. Eg: BTCUSD. Defaults to USD if not provided. String, optional
    # book          - Filter orders. [buy|sell|all], string, optional
    # limit         - Limit resut count. Integer, optional
    def orders params={}
      params = get_defaults(params)
      path   = join_params(params, :currency_pair, :book, :limit)
      request(:get, "/stats/orders/#{path}")
    end
  end
end
