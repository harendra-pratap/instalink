FactoryBot.define do
  factory :post do
    content { Faker::Lorem.sentence }
    location { Faker::Address.full_address }
    user
  end
end
