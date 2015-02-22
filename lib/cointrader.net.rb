require "cointrader.net/version"
require "cointrader.net/client"

module Cointrader
  class Configuration
    attr_accessor :api_key, :api_secret, :api_url

    def initialize
      self.api_key    = nil
      self.api_secret = nil
      self.api_url    = nil
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end
end
