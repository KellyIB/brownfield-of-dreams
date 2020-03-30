class Users::FriendsController < ApplicationController

  def create
    friend = UserFriend.create(user_id: current_user.id, friend_id: params[:friend_id])
    if friend.save
      flash[:success] = "A friend was added to your friend list!"
    else
      flash[:error] = friend.errors.full_messages.to_sentence
    end
    redirect_to '/dashboard'
  end

end
