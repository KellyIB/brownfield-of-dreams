class Users::InvitationsController < ApplicationController
  def new

  end

  def create
    search_facade = SearchFacade.new(current_user)
    invitee = search_facade.get_user_email(params[:github_handle])
    # happy path
      # UserMailer.registration_invitation(current_user, invitee).deliver
      flash[:success] = "Successfully sent invite!"
    redirect_to dashboard_path
  end
end
