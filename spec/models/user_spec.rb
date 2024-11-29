require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:posts).dependent(:destroy) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:chats_as_sender).class_name('Chat').with_foreign_key('sender_id').dependent(:destroy) }
  it { should have_many(:chats_as_receiver).class_name('Chat').with_foreign_key('receiver_id').dependent(:destroy) }
  it { should have_one_attached(:profile_picture) }
  
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:phone_number) }
  it { should validate_numericality_of(:phone_number).only_integer }
  it { should validate_length_of(:password).is_at_least(6) }
end
