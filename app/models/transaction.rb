class Transaction < ActiveRecord::Base
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  # Validaciones de presencia para asegurarse de que los campos no sean nulos
  validates :currency_sent, :currency_received, :amount_sent,:amount_received ,presence: true
  validates :amount_sent, numericality: { greater_than: 0 }
  validates :amount_received, numericality: { greater_than: 0 }
  # Validación personalizada para asegurarse de que las monedas enviadas y recibidas son diferentes
  validate :different_currencies

  private

  def different_currencies
    if currency_sent == currency_received
      errors.add(:currency_received, "must be different from currency sent")
    end
  end
end
