FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    explanation { Faker::Lorem.sentence }
    category_id { Faker::Number.between(from: 2, to: 11) } # 2以上11以下をランダム生成
    condition_id { Faker::Number.between(from: 2, to: 7) } # 2以上7以下をランダム生成
    delivery_charge_id { Faker::Number.between(from: 2, to: 3) } # 2以上3以下をランダム生成
    delivery_city_id { Faker::Number.between(from: 2, to: 48) } # 2以上48以下をランダム生成
    delivery_day_id { Faker::Number.between(from: 2, to: 4) } # 2以上4以下をランダム生成
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
