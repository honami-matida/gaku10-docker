FactoryBot.define do
  factory :customer do
    name { "テストユーザー" }
    email { Faker::Internet.unique.email }
    password { "password" }
    introduction { "テスト用の自己紹介です。" }
    is_active { true }
  end
end