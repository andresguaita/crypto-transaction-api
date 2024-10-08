class CreateTransactions < ActiveRecord::Migration[6.1]
    def change
      create_table :transactions do |t|
        t.references :user, null: false, foreign_key: true
        t.string :currency_sent, null: false
        t.string :currency_received, null: false
        t.decimal :amount_sent, precision: 10, scale: 2, null: false
        t.decimal :amount_received, precision: 16, scale: 8, null: false
  
        t.timestamps
      end
    end
end
  