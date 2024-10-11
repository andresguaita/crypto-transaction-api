class CreateTransactions < ActiveRecord::Migration[6.1]
    def change
      create_table :transactions do |t|
        t.references :user, null: false, foreign_key: { to_table: :users }  # Relación con la tabla 'user'
        t.string :currency_sent, null: false
        t.string :currency_received, null: false
        t.decimal :amount_sent, precision: 30, scale: 8, null: false
        t.decimal :amount_received, precision: 30, scale: 8, null: false
        t.date :finalize_at, default: -> { 'CURRENT_DATE' }
        t.timestamps
      end
    end
  end
  