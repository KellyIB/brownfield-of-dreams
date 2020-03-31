class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :user_friends
  has_many :friends, through: :user_friends

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest, :first_name, :last_name
  enum role: [:default, :admin]
  has_secure_password

  before_create :set_confirmation_token

  def friend?(id)
    friend = User.find_by(github_id: id)
    friends.include?(friend)
  end

  def sorted_bookmarks
    videos.order(:tutorial_id, :position)
  end

  private

    def set_confirmation_token
      if self.confirmation_token.blank?
          self.confirmation_token = SecureRandom.urlsafe_base64.to_s
      end
    end

end
