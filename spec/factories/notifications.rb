FactoryBot.define do
  factory :notification do
    receiver { association :user }
    sender { association :user }
    message { "Sample notification message" }
    read { false }
  end
end
