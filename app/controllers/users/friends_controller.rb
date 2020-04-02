class Users::FriendsController < ApplicationController
  def create
    friend = User.find_by(github_id: params[:friend_github_id])
    new_friend = UserFriend.new(user: current_user, friend: friend)
    if new_friend.save
      flash[:success] = 'A friend was added to your friend list!'
    else
      flash[:error] = new_friend.errors.full_messages.to_sentence
    end
    redirect_to '/dashboard'
  end
end
