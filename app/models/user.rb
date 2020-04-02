class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :user_friends
  has_many :friends, through: :user_friends

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest, :first_name, :last_name
  enum role: %i[default admin]
  has_secure_password

  before_create :set_confirmation_token

  def sorted_bookmarks
    videos.order(:tutorial_id, :position)
  end

  def activate
    self.status = 'active'
    self.confirmation_token = nil
    save
  end

  def friendable?(follower)
    user = User.find_by(github_id: follower.id)
    !user.nil? && !friends.include?(user)
  end

  private

  def set_confirmation_token
    if confirmation_token.blank?
      self.confirmation_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
