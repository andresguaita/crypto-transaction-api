class CreateUsers < ActiveRecord::Migration[6.1]
    def change
      create_table :users do |t|
        t.string :name, null: false
        t.string :email, null: false, unique: true
        t.decimal :balance, precision: 10, scale: 2, default: 0.0, null: false
  
        t.timestamps
      end
    end
  end
  