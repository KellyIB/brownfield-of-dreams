require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it {should have_many :user_videos}
    it {should have_many(:videos).through(:user_videos)}
    it {should have_many :user_friends}
    it {should have_many(:friends).through(:user_friends)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'methods' do
    it 'friend?' do
      user_1 = create(:user, github_id: '123', github_token: 'z0z9zu')
      user_2 = create(:user, github_id: '567', github_token: 'q3w4e5')

      expect(user_1.friend?(user_2.github_id)).to eq(false)

      UserFriend.create(user: user_1, friend: user_2)

      expect(user_1.friend?(user_2.github_id)).to eq(true)
    end
  end
end
