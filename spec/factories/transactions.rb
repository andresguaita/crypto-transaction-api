FactoryBot.define do
    factory :transaction do
      currency_sent { "USD" }
      currency_received { "BTC" }
      amount_sent { 1000 }
      amount_received { 0.2 }
      association :user
    end
end
  