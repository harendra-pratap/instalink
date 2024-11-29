class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'
  belongs_to :followee, class_name: 'User', foreign_key: 'followee_id'

  validates :follower_id, uniqueness: { scope: :followee_id, message: "You already follow this user" }
  validates :status, inclusion: { in: %w[pending accepted] }
end