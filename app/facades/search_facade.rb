class SearchFacade
  def get_repos(user)
    service = GithubService.new
    repo_data = service.get_repo_data(user)
    repo_data.map do |repo_attributes|
      Repo.new(repo_attributes)
    end
  end
end
