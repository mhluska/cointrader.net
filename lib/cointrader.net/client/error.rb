module Cointrader 
  class Error               < StandardError; end
  class Unauthorized        < Error; end
  class CouldNotCancelOrder < Error; end
  class OrderNotFound       < Error; end
  class NoOpenOrders        < Error; end
  class LimitBuyError       < Error; end
  class LimitSellError      < Error; end
  class MarketBuyError      < Error; end
  class MarketSellError     < Error; end
end
