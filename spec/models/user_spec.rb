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

    it 'sorted_bookmarks' do
      tutorial1 = create(:tutorial, title: "How to Tie Your Shoes")
      tutorial2 = create(:tutorial, title: "How to Learn Karate")
      create(:video, title: "Sweep the Leg", tutorial: tutorial2, position: 3)
      video2 = create(:video, title: "The Bunny Round the Bush Technique", tutorial: tutorial1, position: 2)
      video3 = create(:video, title: "Sand the Floor Technique", tutorial: tutorial2, position: 3)
      video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial1, position: 1)
      video5 = create(:video, title: "Wax On, Wax Off Technique", tutorial: tutorial2, position: 2)
      video4 = create(:video, title: "Paint the Fence Technique", tutorial: tutorial2, position: 1)
      create(:video, title: "The Crane", tutorial: tutorial2, position: 4)
      user = create(:user)
      create(:user_video, video_id: video2.id, user_id: user.id)
      create(:user_video, video_id: video5.id, user_id: user.id)
      create(:user_video, video_id: video4.id, user_id: user.id)
      create(:user_video, video_id: video3.id, user_id: user.id)
      create(:user_video, video_id: video1.id, user_id: user.id)

      expect(user.sorted_bookmarks).to eq([video1, video2, video4, video5, video3])
    end
  end
end
