class FollowsController < ApplicationController
  def create
    Follow.create(follower_params)
    redirect_to '/users/profile'
  end
  def dejar
    @follower=Follow.find(params[:id])
    @follower.delete
    redirect_to '/users/profile'
  end
  private
  def follower_params
    params.require(:follow).permit(:follower,:followed)
  end
end
