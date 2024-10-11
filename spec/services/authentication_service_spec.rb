require 'rails_helper'

RSpec.describe AuthenticationService, type: :service do
  let(:user) { create(:user, password: 'password123') }

  describe '#authenticate' do
    context 'with valid credentials' do
      it 'authenticates the user and returns a token' do
        service = AuthenticationService.new(user.email, 'password123')
        result = service.authenticate

        expect(result[:user]).to eq(user)
        expect(result[:token]).to be_present
      end
    end

    context 'with invalid credentials' do
      it 'returns an error with wrong email' do
        service = AuthenticationService.new('wrong@example.com', 'password123')
        result = service.authenticate

        expect(result[:error]).to eq('Invalid email or password')
      end

      it 'returns an error with wrong password' do
        service = AuthenticationService.new(user.email, 'wrongpassword')
        result = service.authenticate

        expect(result[:error]).to eq('Invalid email or password')
      end
    end
  end
end
