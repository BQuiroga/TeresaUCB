class UsersController < ApplicationController
	def profile
		@posts= current_user.posts
		@follows= Follow.where(follower: current_user.id)
		@follows.each do |follow|
			@posts2= Post.where(user_id: follow.followed)
			@posts=@posts+@posts2
		end
	end
end
