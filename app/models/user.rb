class User < ApplicationRecord

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :chats_as_sender, class_name: 'Chat', foreign_key: 'sender_id', dependent: :destroy
  has_many :chats_as_receiver, class_name: 'Chat', foreign_key: 'receiver_id', dependent: :destroy
  has_many :follower_relationships, class_name: 'Follow', foreign_key: 'followed_id'
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :following_relationships, class_name: 'Follow', foreign_key: 'follower_id'
  has_many :following, through: :following_relationships, source: :followed

  validates :first_name, :last_name, presence: true
  validates :phone_number, uniqueness: true, numericality: { only_integer: true }, length: { is: 10 }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  validates :device_language, inclusion: { in: %w[en es fr de it], message: "%{value} is not a valid language" }
end

