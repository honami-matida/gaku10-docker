FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 30) }

    after(:build) do |post|
      genre = build(:genre)
      genre.id = 1  # ダミーidをセット（DBアクセスしない）
      post.genre = genre

      post.customer ||= build(:customer)
    end
  end
end
