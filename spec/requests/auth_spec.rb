require 'swagger_helper'

RSpec.describe 'Authentication API', type: :request do
  path '/login' do
    post 'Autentica al usuario' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: :login, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password']
      }

      response '200', 'Usuario autenticado' do
        let(:user) { create(:user, email: 'john.doe@example.com', password: 'password123') }
        let(:login) { { email: user.email, password: 'password123' } }

        run_test! do
          expect(JSON.parse(response.body)).to include("token")
        end
      end

      response '401', 'Credenciales inválidas' do
        let(:user) { create(:user, email: 'john.doe@example.com', password: 'password123') }
        let(:login) { { email: user.email, password: 'wrong_password' } }

        run_test! do
          expect(JSON.parse(response.body)["error"]).to eq("Invalid email or password")
        end
      end
    end
  end

  path '/register' do
    post 'Registra un nuevo usuario' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: :register, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: ['name', 'email', 'password', 'password_confirmation']
      }

      response '201', 'Usuario registrado' do
        let(:register) { { name: 'John', email: 'john@example.com', password: 'password', password_confirmation: 'password' } }

        run_test! do
          expect(JSON.parse(response.body)["user"]["email"]).to eq('john@example.com')
        end
      end

      response '422', 'Error en el registro' do
        let(:register) { { name: '', email: 'invalid', password: 'pass', password_confirmation: 'mismatch' } }

        run_test! do
          expect(JSON.parse(response.body)["error"]).to eq('Failed to create user')
        end
      end
    end
  end
end
