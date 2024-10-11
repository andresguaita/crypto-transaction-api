require 'rails_helper'

RSpec.describe TransactionService, type: :service do
  let(:user) { create(:user) }
  let(:send_wallet) { create(:wallet, user: user, currency: 'USD', balance: 5000) }
  let(:receive_wallet) { create(:wallet, user: user, currency: 'BTC', balance: 1) }
  let(:params) { { currency_sent: 'USD', currency_received: 'BTC', amount_sent: 1000 } }

  before do
    send_wallet
    receive_wallet
  end

  describe '#process_transaction' do
    context 'when wallets exist' do
      it 'processes the transaction successfully' do
        service = TransactionService.new(user, params)
        allow(BitcoinPriceService).to receive(:get_usd_price).and_return(50000)

        result = service.process_transaction


        expect(service.errors).to be_empty
        expect(service.transaction).to be_present
        expect(service.transaction.amount_received).to be > 0
      end
    end

    context 'when sender wallet is missing' do
      it 'returns an error for missing wallet' do
        send_wallet.destroy 

        service = TransactionService.new(user, params)
        result = service.process_transaction

        expect(result).to eq(false)
        expect(service.errors).to include('One of the wallets does not exist')
      end
    end

    context 'when insufficient balance' do
      it 'returns an error for insufficient balance' do
        send_wallet.update(balance: 50)

        service = TransactionService.new(user, params)
        result = service.process_transaction

        expect(result).to eq(false)
        expect(service.errors).to include('Insufficient balance')
      end
    end

    context 'when Bitcoin price is not available' do
      it 'returns an error if the BTC price is unavailable' do
        allow(BitcoinPriceService).to receive(:get_usd_price).and_return(nil)

        service = TransactionService.new(user, params)
        result = service.process_transaction

        expect(result).to eq(false)
        expect(service.errors).to include('Could not retrieve Bitcoin price')
      end
    end
  end
end
