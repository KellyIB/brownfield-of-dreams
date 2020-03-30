class Users::FriendsController < ApplicationController

  def create
    friend = User.find_by(github_id: params[:friend_github_id])
    addedFriend = UserFriend.new(user: current_user, friend: friend)
    if addedFriend.save
      flash[:success] = "A friend was added to your friend list!"
    else
      addedFlash[:error] = addedFriend.errors.full_messages.to_sentence
    end
    redirect_to '/dashboard'
  end

end
