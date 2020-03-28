class Users::DashboardController < ApplicationController

  def index
    if current_user.github_token
      @search_facade = SearchFacade.new(current_user)
    end
  end

end
