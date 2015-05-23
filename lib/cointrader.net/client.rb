require_relative 'client/request'
require_relative 'client/stats'
require_relative 'client/account'
require_relative 'client/order'

module Cointrader
  class Client
    include Cointrader::Request
    include Cointrader::Stats
    include Cointrader::Account
    include Cointrader::Order
  end
end
