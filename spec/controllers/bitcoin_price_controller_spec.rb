require 'rails_helper'

RSpec.describe BitcoinPriceController, type: :controller do
  describe "GET #show" do
    it "returns the Bitcoin price in USD" do
      allow(BitcoinPriceService).to receive(:get_usd_price).and_return(50000)
      get :show
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["btc_price_in_usd"]).to eq(50000)
    end

    it "returns an error if the service is unavailable" do
      allow(BitcoinPriceService).to receive(:get_usd_price).and_return(nil)
      get :show
      expect(response).to have_http_status(:service_unavailable)
    end
  end
end
