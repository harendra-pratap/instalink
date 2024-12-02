class Chat < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :original_message, presence: true
  # validates :translated_message, presence: true
  validates :language, inclusion: { in: %w[en es fr de it], message: "%{value} is not a valid language" }

  def translate_message
    self.translated_message = original_message
  end
end
