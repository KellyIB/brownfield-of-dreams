class GithubService
  def get_repo_data(user)
    get_json(user, "/user/repos?sort=created&direction=asc")
  end

  def get_follower_data(user)
    get_json(user, "/user/followers")
  end

  def get_following_data(user)
    get_json(user, "/user/following")
  end

  private

    def get_json(user, url)
      response = conn(user).get(url)
      JSON.parse(response.body, symbolize_names: true)
    end

    def conn(user)
      Faraday.new(url: "https://api.github.com") do |f|
        f.headers["Authorization"] = "token #{user.github_token}"
      end
    end
end
