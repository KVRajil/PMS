require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  context 'validation test' do
    it 'ensures username presence' do
      user.username = nil
      expect(user).to_not be_valid
    end

    it 'ensures email presence' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'ensures username uniqueness' do
      new_user = user.dup
      new_user.email = 'valid_uniq@test.com'
      p User.all
      expect(new_user).to_not be_valid
    end

    it 'ensures email uniqueness' do
      new_user = user.dup
      new_user.username = 'test_uniq'
      expect(new_user).to_not be_valid
    end
  end
end
