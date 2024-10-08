class Users < ApplicationRecord
    has_many :transactions
  
    # Validaciones
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :balance, numericality: { greater_than_or_equal_to: 0 }
  

end
  