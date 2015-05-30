require 'spec_helper'

describe Cointrader::Client do
  def limit_buy 
    subject.limit_buy(total_quantity: 1, price: 10)
  end

  def limit_sell
    subject.limit_sell(total_quantity: 1, price: 10)
  end

  def safe_limit_buy
    VCR.use_cassette('limit_buy', &method(:limit_buy))
  end

  def safe_limit_sell
    VCR.use_cassette('limit_sell', &method(:limit_sell))
  end

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

    describe '#tradehistory' do
      it 'returns trade history' do
        VCR.use_cassette('tradehistory') do
          response = subject.tradehistory

          expect_success(response)
          expect(response['data'][0]['fee']).not_to be_nil
        end
      end
    end
  end

  describe 'order' do
    describe '#limit_buy' do
      it 'returns an order' do
        VCR.use_cassette('limit_buy') do
          response = limit_buy

          expect_success(response)
          expect(response['data']['id']).not_to be_nil
        end
      end
    end

    describe '#limit_sell' do
      it 'returns an order' do
        VCR.use_cassette('limit_sell') do
          response = limit_sell

          expect_success(response)
          expect(response['data']['id']).not_to be_nil
        end
      end
    end

    describe '#cancel' do
      let(:order) { safe_limit_buy }

      it 'cancels and order' do
        VCR.use_cassette('cancel') do
          response = subject.cancel(id: order['data']['id'])

          expect_success(response)
          expect(response['data']['id']).not_to be_nil
          expect(response['data']['currency_pair']).not_to be_nil
        end
      end
    end

    describe '#list' do
      it 'lists open limit orders' do
        VCR.use_cassette('list') do
          response = subject.list

          expect_success(response)
          expect(response['data'][0]['type'])
        end
      end
    end

    describe '#trades' do
      it 'lists recent trades executed' do
        VCR.use_cassette('trades') do
          response = subject.trades

          expect_success(response)
          expect(response['data'][0]['price'])
        end
      end
    end
  end
end
