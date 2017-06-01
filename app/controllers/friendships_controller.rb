class FriendshipsController < ApplicationController
  def friend
    @user=current_user
    @friend_id=params[:id]
    Friendship.create(one:@user.id,two:@friend_id)
    redirect_to '/users/profile'
  end
  def notmine
    @user=current_user
    @friend_id=params[:id]
    @friends=Friendship.where(one:@user.id,two:@friend_id)
    if !@friends
      @friends=Friendship.where(one:@friend_id,two:@user.id)
    end
    @friends.first.delete
    redirect_to '/users/profile'
  end
end
