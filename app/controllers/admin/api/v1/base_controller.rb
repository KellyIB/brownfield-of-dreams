class Admin::Api::V1::BaseController < ActionController::API
  before_action :require_admin

  def require_admin
    render file: '/public/404' unless current_user && current_user.admin?
  end

  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
