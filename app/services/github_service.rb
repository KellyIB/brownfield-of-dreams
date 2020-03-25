class GithubService

  def get_repo_data(user)
    response = conn(user).get("/user/repos?sort=created&direction=asc")
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn(user)
    Faraday.new(url: "https://api.github.com") do |f|
      f.headers["Authorization"] = user.github_token
    end
  end

end
