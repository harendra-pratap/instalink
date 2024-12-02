class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  validates :content, presence: true
  # validates :location, presence: true
  validate :validate_image_type

  after_create :analyze_sentiment

  private

  def analyze_sentiment
    self.sentiment_score = 0.5
    self.sentiment_type = "positive"
    save
  end

  def validate_image_type
    images.each do |image|
      if !image.content_type.in?(%w[image/jpeg image/png image/gif])
        errors.add(:images, "must be a JPEG, PNG, or GIF")
      end
    end
  end
end