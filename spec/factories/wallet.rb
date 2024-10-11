FactoryBot.define do
    factory :wallet do
      currency { 'USD' }
      balance { 1000.0 }
      association :user
    end
  end
  