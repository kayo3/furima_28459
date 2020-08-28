FactoryBot.define do
  factory :order_delivery do
    postal_code   {"123-5678"}
    prefecture_id {Faker::Number.between(from: 2, to: 48)}
    city          {Faker::Address.city}
    block         {"番地"}
    tel_number    {Faker::Number.leading_zero_number(digits: 11)}
    token         {Faker::Lorem.word}
  end
end