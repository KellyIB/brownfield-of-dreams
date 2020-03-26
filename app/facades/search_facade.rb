class SearchFacade

  def get_repos(user)
    service = GithubService.new
    repo_data = service.get_repo_data(user)
    repo_data.map do |repo_attributes|
      Repo.new(repo_attributes)
    end
  end

  def get_followers(user)
    service = GithubService.new
    follower_data = service.get_follower_data(user)
    follower_data.map do |follower_attributes|
      Follower.new(follower_attributes)
    end
  end
end
