FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation {password}
    last_name             {'山田ヤマダやまだ'}
    first_name            {'山田ヤマダやまだ'}
    last_name_kana        {'テスト'}
    first_name_kana       {'テスト'}
    birthday              {Faker::Date.birthday}
  end
end