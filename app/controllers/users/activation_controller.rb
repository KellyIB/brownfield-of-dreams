class Users::ActivationController < ApplicationController

  def update
    user = User.find_by(confirmation_token: params[:token])
    if user
      user.activate
      flash[:success] = "Thank you! Your account is now activated."
    else
      flash[:error] = "Something went wrong."
    end
    redirect_to root_path
  end
end
