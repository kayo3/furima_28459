FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.unique.free_email}
    password              {Faker::Internet.password(min_length: 6, mix_case: true)}
    password_confirmation {password}
    last_name             {"ふり間"}
    first_name            {"太郎"}
    last_name_kana        {"フリマ"}
    first_name_kana       {"タロウ"}
    birthday              {Faker::Date.between(from: '1930-01-01', to: '2015-12-31') }
  end
end