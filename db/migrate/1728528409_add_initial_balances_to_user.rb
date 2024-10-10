class AddInitialBalancesToUser < ActiveRecord::Migration[6.0]
    def up
      # Verificamos que el usuario con user_id = 1 exista antes de agregar los balances
      user = User.find_by(id: 1)
      if user
        Wallet.create!(user_id: 1, currency: 'USD', balance: 10000)
        Wallet.create!(user_id: 1, currency: 'BTC', balance: 0)
      else
        raise ActiveRecord::Rollback, "User with ID 1 not found"
      end
    end
  
    def down
      # Para revertir la migración, eliminamos los balances creados
      Wallet.where(user_id: 1, currency: ['USD', 'BTC']).destroy_all
    end
  end
  