module Cointrader
  module Order
    def limit_buy params={}
      params = get_defaults(params)
      request(:post, "/order/#{params[:currency_pair]}/buy", total_quantity: params[:total_quantity], price: params[:price])
    end

    def limit_sell params={}
      params = get_defaults(params)
      request(:post, "/order/#{params[:currency_pair]}/sell", total_quantity: params[:total_quantity], price: params[:price])
    end

    def cancel params={}
      params = get_defaults(params)
      request(:post, "/order/#{params[:currency_pair]}/cancel")
    end

    def list params={}
      params = get_defaults(params)
      request(:post, "/order/#{params[:currency_pair]}/list")
    end

    def market_buy params={}
      params = get_defaults(params)
      request(:post, "/order/#{params[:currency_pair]}/marketbuy", total_amount: params[:total_amount])
    end

    def market_sell params={}
      params = get_defaults(params)
      request(:post, "/order/#{params[:currency_pair]}/marketsell", total_amount: params[:total_amount])
    end
  end
end
