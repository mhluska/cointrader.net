require 'spec_helper'

describe Cointrader::Client do
  describe 'stats' do
    describe '#symbol' do
      it 'returns supported currencies' do
        VCR.use_cassette('symbol') do
          response = subject.symbol

          expect_success(response)
          expect(response['data'][0]['name']).to eq 'Bitcoin (BTC)'
        end
      end
    end
  end

  describe 'account' do
    describe '#balance' do
      it 'returns a balance' do
        VCR.use_cassette('balance') do
          response = subject.balance

          expect_success(response)
          expect(response['data']['BTC']['available']).not_to be_nil
        end
      end
    end
  end
end
