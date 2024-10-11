require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let(:user) { create(:user) }
  let(:transaction) { create(:transaction, user: user) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "GET #index" do
    it "returns a list of transactions for the user" do
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(:ok)
    end

    it "returns an error if user is not found" do
      get :index, params: { user_id: 999 }
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)["error"]).to eq("User not found")
    end
  end

  describe "POST #create" do
    before do
      user.wallets.create(currency: 'USD', balance: 1000)
      user.wallets.create(currency: 'BTC', balance: 0.2)
    end
    it "creates a transaction and returns it" do
      post :create, params: { currency_sent: 'USD', currency_received: 'BTC', amount_sent: 1000 }
      expect(response).to have_http_status(:created)
    end

    it "returns an error when creation fails" do
      post :create, params: { currency_sent: 'BTC', currency_received: 'BTC', amount_sent: 1000 }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "GET #show" do
    it "returns the requested transaction" do
      get :show, params: { id: transaction.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(transaction.id)
    end

    it "returns an error if transaction is not found" do
      get :show, params: { id: 999 }
      expect(response).to have_http_status(:not_found)
    end
  end
end
