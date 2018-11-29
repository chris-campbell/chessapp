require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User' do

    it "email should be present" do
      user1 = FactoryBot.create(:user)
      user1.email = "     "
      expect(user1.valid?).to eq false
    end

    it "email addresses should be unique" do
      user = FactoryBot.create(:user)
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      expect(duplicate_user.valid?).to eq false
    end
  end
end
