class CreateTransactions < ActiveRecord::Migration[6.1]
    def change
      create_table :transaction do |t|
        t.references :user, null: false, foreign_key: { to_table: :users }  # Relación con la tabla 'user'
        t.string :currency_sent, null: false
        t.string :currency_received, null: false
        t.decimal :amount_sent, precision: 10, scale: 2, null: false
        t.decimal :amount_received, precision: 10, scale: 2, null: false
        t.date :finalize_at
        t.timestamps
      end
    end
  end
  