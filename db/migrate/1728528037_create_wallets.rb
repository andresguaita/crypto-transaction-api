class CreateWallets < ActiveRecord::Migration[6.0]
    def change
      create_table :wallets do |t|
        t.references :user, null: false, foreign_key: true
        t.string :currency, null: false
        t.decimal :balance, precision: 16, scale: 8, default: 0, null: false
  
        t.timestamps
      end
  

      add_index :wallets, [:user_id, :currency], unique: true
    end
  end
  