class Transaction < ActiveRecord::Base
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  validates :currency_sent, :currency_received, :amount_sent, :amount_received, presence: true
  validates :amount_sent, numericality: { greater_than: 0 }
end
