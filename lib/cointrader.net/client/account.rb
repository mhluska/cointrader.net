module Cointrader
  module Account
    def balance params={}
      request(:post, '/account/balance', params)
    end

    def tradehistory params={}
      params = get_defaults(params)
      request(:post, "/account/tradehistory/#{params[:currency_pair]}")
    end
  end
end
