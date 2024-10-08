class Transactions < ApplicationRecord
  belongs_to :user

  validates :currency_sent, :currency_received, :amount_sent, :amount_received, presence: true
  validates :amount_sent, numericality: { greater_than: 0 }
end
