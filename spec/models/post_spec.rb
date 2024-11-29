require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:comments) }
  it { should have_many(:likes) }
  it { should have_many_attached(:images) }

  it { should validate_presence_of(:content) }
end
