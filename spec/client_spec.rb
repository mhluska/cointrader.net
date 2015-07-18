require 'spec_helper'

describe Cointrader::Client, vcr: true do
  def limit_buy 
    subject.limit_buy(total_quantity: 1, price: 10)
  end

  def limit_sell
    subject.limit_sell(total_quantity: 1, price: 10)
  end

  def market_buy
    subject.market_buy(total_amount: 1)
  end

  def market_sell
    subject.market_sell(total_amount: 1)
  end

  describe 'stats' do
    describe '#symbol' do
      it 'returns supported currencies' do
        response = subject.symbol
        expect_success(response)
        expect(response['data'][0]['name']).to eq 'Bitcoin (BTC)'
      end
    end

    describe '#stats_24h' do
      it 'returns 24 hour sliding statistics' do
        response = subject.stats_24h
        expect_success(response)
      end
    end

    describe '#stats_7d' do
      it 'returns 7 day sliding statistics' do
        response = subject.stats_7d
        expect_success(response)
      end
    end

    describe '#orders' do
      it 'returns open orders' do
        response = subject.orders
        expect_success(response)
      end
    end
  end

  describe 'account' do
    describe '#balance' do
      it 'returns a balance' do
        response = subject.balance

        expect_success(response)
        expect(response['data']['BTC']['available']).not_to be_nil
      end
    end

    describe '#tradehistory' do
      it 'returns trade history' do
        response = subject.tradehistory
        expect_success(response)
      end
    end
  end

  describe 'order' do
    describe '#limit_buy' do
      it 'returns an order' do
        response = limit_buy
        expect_success(response)
        expect(response['data']['id']).not_to be_nil
      end

      it 'throws an error when there are insufficient funds' do
        expect { subject.limit_buy(price: 1_000_000, total_quantity: 1) }.to raise_error(Cointrader::LimitBuyError)
      end
    end

    describe '#limit_sell' do
      it 'returns an order' do
        response = limit_sell
        expect_success(response)
        expect(response['data']['id']).not_to be_nil
      end
    end

    describe '#cancel' do
      let(:order) { limit_buy }

      it 'cancels an order' do
        response = subject.cancel(order_id: order['data']['id'])
        expect_success(response)
      end
    end

    describe '#list' do
      context 'when there are orders' do
        let(:order) { limit_buy }
        after { subject.cancel(order_id: order['data']['id'] )}

        it 'lists open limit orders' do
          order
          response = subject.list
          expect_success(response)
        end
      end

      context 'when there are no orders' do
        it 'throws an error' do
          expect { subject.list }.to raise_error(Cointrader::NoOpenOrders)
        end
      end
    end

    describe '#market_buy' do
      it 'returns an order' do
        response = market_buy
        expect_success(response)
        expect(response['message']).not_to eq('Unauthorized')
      end
    end

    describe '#market_sell' do
      it 'returns an order' do
        response = market_sell
        expect_success(response)
        expect(response['message']).not_to eq('Unauthorized')
      end
    end

    describe '#trades' do
      it 'lists recent trades executed' do
        response = subject.trades
        expect_success(response)
      end
    end
  end
end
