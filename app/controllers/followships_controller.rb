class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])
    if @followship.save
      flash[:success] = "Followed successfully!"
      redirect_to user_path(params[:following_id])
    end
  end

  def destroy
    @followship = current_user.followships.find(params[:id])
    id = @followship.following.id
    
    @followship.destroy
    flash[:success] = "Stop follow successfully!"
    redirect_to user_path(id)
  end
end
