class User < ActiveRecord::Base
    has_secure_password
  
    has_many :transactions, class_name: 'Transaction', foreign_key: 'user_id', dependent: :destroy
    has_many :wallets

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true
  end
  