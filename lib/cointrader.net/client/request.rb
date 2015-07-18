require 'rest-client'
require 'json'
require 'openssl'
require 'date'
require 'uri'

module Cointrader
  module Request
    API_URL = "https://www.cointrader.net/api4"

    protected

    def join_params params, *names
      names.map { |name| params[name] }.compact.join('/')
    end

    def convert_values params
      pairs = params.map do |k, v|
        new_value =
          if k.match(/price|total_amount/)
            "%04.2f" % v
          elsif k.match(/amount|quantity/)
            "%04.8f" % v
          else
            v
          end

        [k, new_value]
      end

      Hash[pairs]
    end

    def get_defaults params
      defaults = {
        currency_pair: Client::DEFAULT_CURRENCY_PAIR
      }
      defaults.merge(convert_values(params))
    end

    def request(method, path, body={})
      check_errors(JSON.parse(hmac_request(method, path, body)))
    end

    private

    def hmac_request method, path, body={}
      payload = {}
      headers = { :content_type => 'application/json' }
      base    = Cointrader.configuration.api_url || API_URL
      url     = base + path

      if method == :get && !body.empty?
        url += '?' + URI.encode_www_form(body)
      else
        api_key    = Cointrader.configuration.api_key
        api_secret = Cointrader.configuration.api_secret

        raise 'API key and API secret are required!' unless api_key && api_secret

        payload = body.merge({
          secret: api_secret,
          t: Time.now.utc.to_s
        })

        digest    = OpenSSL::Digest.new('sha256')
        signature = OpenSSL::HMAC.hexdigest(digest, api_secret, payload.to_json)

        headers.merge!({
          'X-Auth' => api_key,
          'X-Auth-Hash' => signature,
        })
      end

      RestClient::Request.execute(
        url: url,
        method: method,
        payload: payload.to_json,
        headers: headers,
      )
    end

    # Returns the error code from `response` or `nil` if there is none.
    def extract_error_code response
      return unless response
      return unless response['data'] && response['data'].class == Hash
      return unless response['data']['errorCode']

      response['data']['errorCode'].to_i
    end

    def check_errors response
      code = extract_error_code(response)

      if code
        errorClass = 
          case code
          when 401 then Unauthorized
          when 799 then CouldNotCancelOrder
          when 801 then NoOpenOrders
          when 802 then LimitBuyError
          when 803 then LimitSellError
          when 804 then MarketBuyError
          when 805 then MarketSellError
          else Error
          end

        raise errorClass.new(code.to_s + ' ' + response['message'])
      end

      response
    end
  end
end
