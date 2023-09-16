FactoryBot.define do
  factory :order_form do
    postal_code { '000-0000' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city { Faker::Address.city }
    house_number { Faker::Address.street_address }
    building_name { Faker::Address.street_address }
    telephone_number { '0000000000' }
    token { Faker::Internet.password(min_length: 20, max_length: 30) }
  end
end
