class Users::DashboardController < ApplicationController
  def index
    @search_facade = SearchFacade.new(current_user) if current_user.github_token
  end
end
