class SearchFacade

  def initialize(user)
    @service = GithubService.new
    @user = user
  end

  def get_repos
    repo_data = @service.get_repo_data(@user)
    @repos ||= repo_data.map do |repo_attributes|
      Repo.new(repo_attributes)
    end.first(5)
  end

  def get_followers
    follower_data = @service.get_follower_data(@user)
    @followers ||= follower_data.map do |follower_attributes|
      Follower.new(follower_attributes)
    end
  end

  def get_following
    following_data = @service.get_following_data(@user)
    @following ||= following_data.map do |followed_attributes|
      Follower.new(followed_attributes)
    end
  end

  def get_user(user_handle)
    user_data = @service.get_user_data(@user, user_handle)
    GithubUser.new(user_data)
  end
end
