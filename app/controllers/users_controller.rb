class UsersController < ApplicationController
	def profile
		@posts= Post.all
	end
end
