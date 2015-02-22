module Cointrader
  module Account
    def balance params={}
      request(:post, '/account/balance', params)
    end
  end
end
