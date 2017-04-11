class UsersController < ApplicationController
	def profile
		@posts= Post.find_by(user_id: current_user.id)
	end
end
