class Users::DashboardController < ApplicationController
  def index
    if current_user.github_token
      search_facade = SearchFacade.new
      @repos = search_facade.get_repos(current_user).first(5)
    end
  end
end
