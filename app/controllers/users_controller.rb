class UsersController < ApplicationController
	def profile
		@posts= current_user.posts
		@follows= Follow.where(follower: current_user.id)
		@follows.each do |follow|
			@posts2= Post.where(user_id: follow.followed)
			@posts=@posts+@posts2
		end
		@searched= Searched.where(found: current_user.id)
		@searched.each do |searching_company|
			@posts2= Post.where(user_id: searching_company.searched_by,requiring:true)
			@posts =@posts +@posts2
		end
		@posts=@posts.uniq

	end
end
