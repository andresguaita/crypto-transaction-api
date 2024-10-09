class User < ActiveRecord::Base
    has_secure_password
  
    has_many :transactions, class_name: 'Transaction', foreign_key: 'user_id', dependent: :destroy
  
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :balance, numericality: { greater_than_or_equal_to: 0 }

      # Método para deducir el balance al realizar una transacción
    def deduct_balance(amount)
      update(balance: balance - amount) if balance >= amount
    end
  end
  