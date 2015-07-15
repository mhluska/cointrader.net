require 'vcr'
require 'dotenv'
require_relative '../lib/cointrader.net'

Dotenv.load

def expect_success response
  expect(response).not_to be_nil
  expect(response['message']).not_to eq('Unauthorized')
end

RSpec.configure do |config|
  config.color = true
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.default_cassette_options = { match_requests_on: [:method] }
  config.configure_rspec_metadata!
end

Cointrader.configure do |config|
  config.api_key    = ENV['API_KEY']
  config.api_secret = ENV['API_SECRET']
  config.api_url    = ENV['API_URL'] || 'https://private-anon-e01e290b7-cointrader.apiary-mock.com/api4'
end
