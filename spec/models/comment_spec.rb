require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:post) }
  it { should belong_to(:parent_comment).class_name('Comment').optional }

  it { should validate_presence_of(:content) }
end
