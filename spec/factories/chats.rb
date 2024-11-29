FactoryBot.define do
  factory :chat do
    original_message { Faker::Lorem.sentence }
    translated_message { Faker::Lorem.sentence }
    language { 'en' }
    sender { association :user }
    receiver { association :user }
  end
end
