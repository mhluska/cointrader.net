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

    # TODO(maros): Add more detailed tests.
    describe '#stats_24h' do
      it 'returns 24 hour sliding statistics' do
        VCR.use_cassette('stats_24h') do
          response = subject.stats_24h
          expect_success(response)
        end
      end
    end

    # TODO(maros): Add more detailed tests.
    describe '#stats_7d' do
      it 'returns 7 day sliding statistics' do
        VCR.use_cassette('stats_7d') do
          response = subject.stats_7d
          expect_success(response)
        end
      end
    end

    # TODO(maros): Add more detailed tests.
    describe '#orders' do
      it 'returns open orders' do
        VCR.use_cassette('orders') do
          response = subject.orders
          expect_success(response)
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

  describe 'order' do
    describe '#limit_buy' do
      it 'returns an order' do
        VCR.use_cassette('limit_buy') do
          response = subject.limit_buy(total_quantity: 1, price: 10)

          expect_success(response)
          expect(response['data']['id']).not_to be_nil
        end
      end
    end

    describe '#limit_sell' do
      it 'returns an order' do
        VCR.use_cassette('limit_sell') do
          response = subject.limit_sell(total_quantity: 1, price: 10)

          expect_success(response)
          expect(response['data']['id']).not_to be_nil
        end
      end
    end
  end
end
