class FollowersController < ApplicationController
  def create
    Follow.create(follower_params)
    redirect_to '/users/profile'
  end
  def delete
    @follower=Follow.find(params[:id])
    @follower.delete
  end
  private
  def follower_params
    params.require(:follow).permit(:follower,:followed)
  end
end
