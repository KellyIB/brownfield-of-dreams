class Users::DashboardController < ApplicationController

  def index
    if current_user.github_token
      search_facade = SearchFacade.new
      @github_data = Hash.new
      @github_data[:repos] = search_facade.get_repos(current_user).first(5)
      @github_data[:followers] = search_facade.get_followers(current_user)
    end
  end

end
