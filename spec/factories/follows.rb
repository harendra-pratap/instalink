FactoryBot.define do
  factory :follow do
    follower { association :user }
    followee { association :user }
    status { 'pending' }
  end
end
