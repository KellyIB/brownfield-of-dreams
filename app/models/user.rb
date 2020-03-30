class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :user_friends
  has_many :friends, through: :user_friends
  has_many :tutorial, through: :videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def friend?(id)
    friend = User.find_by(github_id: id)
    friends.include?(friend)
  end

  def has_videos?
    self.videos.count > 0
  end

  def bookmarked_tutorial_videos(current_user)
    current_user.tutorials
  end









end
