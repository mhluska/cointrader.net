require 'rest-client'
require 'json'
require 'openssl'
require 'date'
require 'uri'
require 'digest'

module Cointrader
  module Request
    API_URL = "https://www.cointrader.net/api4"

    protected

    def join_params params, *names
      names.map { |name| params[name] }.compact.join('/')
    end

    def get_defaults params
      defaults = {
        currency_pair: Client::DEFAULT_CURRENCY_PAIR
      }
      defaults.merge(params)
    end

    def request(method, path, body={})
      JSON.parse(hmac_request(method, path, body))
    end

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

        nonce   = DateTime.now.strftime('%Q')
        payload = body.merge({
          secret: api_secret,
          t: nonce,
        })

        secret    = Digest::MD5.hexdigest(api_secret)
        data      = payload.to_json + api_secret
        digest    = OpenSSL::Digest.new('sha256')
        signature = OpenSSL::HMAC.hexdigest(digest, secret, data)

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
  end
end
