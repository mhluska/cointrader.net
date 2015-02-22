require_relative 'client/request'
require_relative 'client/stats'
require_relative 'client/account'

module Cointrader
  class Client
    include Cointrader::Request
    include Cointrader::Stats
    include Cointrader::Account
  end
end
