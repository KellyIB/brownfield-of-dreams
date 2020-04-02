class Users::InvitationsController < ApplicationController
  def new
  end

  def create
    search_facade = SearchFacade.new(current_user)
    invitee = search_facade.get_user(params[:github_handle])
    if invitee.email
      UserMailer.registration_invitation(current_user, invitee).deliver
      flash[:success] = "Successfully sent invite!"
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end
end
