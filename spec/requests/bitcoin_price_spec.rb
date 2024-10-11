require 'swagger_helper'

RSpec.describe 'Bitcoin Price API', type: :request do
  path '/bitcoin_price' do
    get 'Obtiene el precio de Bitcoin en USD' do
      tags 'BitcoinPrice'
      produces 'application/json'

      response '200', 'Precio de Bitcoin en USD encontrado' do
        schema type: :object, properties: {
          btc_price_in_usd: { type: :number }
        }

        before do
          allow(BitcoinPriceService).to receive(:get_usd_price).and_return(50000)
        end

        run_test! do
          expect(JSON.parse(response.body)['btc_price_in_usd']).to eq(50000)
        end
      end

      response '503', 'Servicio no disponible' do
        before do
          allow(BitcoinPriceService).to receive(:get_usd_price).and_return(nil)
        end

        run_test!
      end
    end
  end
end
