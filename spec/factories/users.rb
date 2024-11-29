FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.username }
    phone_number { Faker::Number.number(digits: 10) }
    email { Faker::Internet.email }
    password { 'password123' }
    device_language { 'en' }
  end
end
