class SearchFacade

  def initialize
    @service = GithubService.new
  end

  def get_repos(user)
    repo_data = @service.get_repo_data(user)
    @repos || repo_data.map do |repo_attributes|
      Repo.new(repo_attributes)
    end
  end

  def get_followers(user)
    follower_data = @service.get_follower_data(user)
    @followers || follower_data.map do |follower_attributes|
      Follower.new(follower_attributes)
    end
  end

  def get_following(user)
    following_data = @service.get_following_data(user)
    @following || following_data.map do |followed_attributes|
      Follower.new(followed_attributes)
    end
  end
end
