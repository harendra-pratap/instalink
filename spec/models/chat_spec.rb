require 'rails_helper'

RSpec.describe Chat, type: :model do
  it { should belong_to(:sender).class_name('User') }
  it { should belong_to(:receiver).class_name('User') }

  it { should validate_presence_of(:original_message) }
  it { should validate_presence_of(:translated_message) }
end
