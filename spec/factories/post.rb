FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 30) }
    association :customer
    association :genre  # 自動で関連づける
  end
end
