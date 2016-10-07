class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:success] = "Friend added successfully!"
      redirect_to user_path(params[:friend_id])
    end
  end

  def destroy
    if current_user.friendships.find_by_id(params[:id])
      @friendship = current_user.friendships.find(params[:id])
      id = @friendship.friend.id
    elsif current_user.inverse_friendships.find_by_id(params[:id])
      @friendship = current_user.inverse_friendships.find(params[:id])
      id = @friendship.user.id
    end
    
    @friendship.destroy
    flash[:success] = "Friendship removed successfully!"
    redirect_to user_path(id)
  end
end
