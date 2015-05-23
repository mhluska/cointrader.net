module Cointrader
  module Order
    def limit_buy params={}
      params = get_defaults(params)
      request(:post, "/order/#{params[:currency_pair]}/buy")
    end

    def limit_sell params={}
      params = get_defaults(params)
      request(:post, "/order/#{params[:currency_pair]}/sell")
    end
  end
end
