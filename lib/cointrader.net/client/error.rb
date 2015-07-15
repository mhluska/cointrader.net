module Cointrader 
  class Error             < StandardError; end
  class Unauthorized      < Error; end
  class InsufficientFunds < Error; end
  class NoOpenOrders      < Error; end
end
