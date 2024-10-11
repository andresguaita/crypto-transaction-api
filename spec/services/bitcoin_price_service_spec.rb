require 'rails_helper'

RSpec.describe BitcoinPriceService, type: :service do
  describe '.get_usd_price' do
    context 'when the request is successful' do
      it 'returns the Bitcoin price in USD' do
        response_data = { "bpi" => { "USD" => { "rate_float" => 50000.0 } } }
        allow(HttpClient).to receive(:get).and_return({ status: 200, data: response_data })

        price = BitcoinPriceService.get_usd_price
        expect(price).to eq(50000.0)
      end
    end

    context 'when the request fails' do
      it 'returns an error' do
        allow(HttpClient).to receive(:get).and_return({ status: 500 })

        result = BitcoinPriceService.get_usd_price
        expect(result).to eq({ error: 'Unable to fetch BTC price' })
      end
    end
  end
end
