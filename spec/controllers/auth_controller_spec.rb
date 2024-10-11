require 'rails_helper'

RSpec.describe AuthController, type: :controller do
  describe "POST #login" do
    let(:user) { create(:user, email: 'john.doe@example.com', password: 'password123') }

    it "authenticates the user with valid credentials" do
      post :login, params: { email: user.email, password: 'password123' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to include("token")
    end

    it "returns an error with invalid credentials" do
      post :login, params: { email: user.email, password: 'wrong_password' }
      expect(response).to have_http_status(:unauthorized)
      expect(JSON.parse(response.body)["error"]).to eq("Invalid email or password")
    end
  end

  describe "POST #register" do
    it "registers a new user" do
      post :register, params: { name: 'John', email: 'john@example.com', password: 'password', password_confirmation: 'password' }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["user"]["email"]).to eq('john@example.com')
    end

    it "returns an error when registration fails" do
      post :register, params: { name: '', email: 'invalid', password: 'pass', password_confirmation: 'mismatch' }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)["error"]).to eq('Failed to create user')
    end
  end
end
