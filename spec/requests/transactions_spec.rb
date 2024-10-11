require 'swagger_helper'

RSpec.describe 'Transactions API', type: :request do
  let(:user) { create(:user) }
  let(:transaction) { create(:transaction, user: user) }

  before do
    allow_any_instance_of(TransactionsController).to receive(:current_user).and_return(user)
  end

  path '/users/{user_id}/transactions' do
    get 'Lista de transacciones del usuario' do
      tags 'Transactions'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :integer, description: 'ID del usuario'
      security [Bearer: []]  # Agrega el esquema de seguridad Bearer

      response '200', 'Lista de transacciones encontrada' do
        let(:Authorization) { "Bearer token_valido" }  # Simula el token válido
        run_test!
      end

      response '404', 'Usuario no encontrado' do
        let(:user_id) { 999 }
        let(:Authorization) { "Bearer token_valido" }
        run_test!
      end
    end
  end

  path '/transactions' do
    post 'Crea una nueva transacción' do
      tags 'Transactions'
      consumes 'application/json'
      parameter name: :transaction, in: :body, schema: {
        type: :object,
        properties: {
          currency_sent: { type: :string },
          currency_received: { type: :string },
          amount_sent: { type: :number }
        },
        required: ['currency_sent', 'currency_received', 'amount_sent']
      }
      security [Bearer: []]

      response '201', 'Transacción creada' do
        let(:Authorization) { "Bearer token_valido" }
        let(:transaction) { { currency_sent: 'USD', currency_received: 'BTC', amount_sent: 1000 } }

        run_test!
      end

      response '422', 'Error en la creación de la transacción' do
        let(:Authorization) { "Bearer token_valido" }
        let(:transaction) { { currency_sent: 'BTC', currency_received: 'BTC', amount_sent: 1000 } }

        run_test!
      end
    end
  end

  path '/transactions/{id}' do
    get 'Obtiene una transacción específica' do
      tags 'Transactions'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer, description: 'ID de la transacción'
      security [Bearer: []]

      response '200', 'Transacción encontrada' do
        let(:Authorization) { "Bearer token_valido" }
        let(:id) { transaction.id }

        run_test!
      end

      response '404', 'Transacción no encontrada' do
        let(:Authorization) { "Bearer token_valido" }
        let(:id) { 999 }

        run_test!
      end
    end
  end
end
