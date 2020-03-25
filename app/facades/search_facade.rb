class SearchFacade

  def get_repos(user)
    service = GithubService.new
    repo_data = service.get_repo_data(user)
    repo_data.map do |repo|
      Repo.new(repo)
    end
  end


end
