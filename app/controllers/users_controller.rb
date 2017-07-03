class UsersController < ApplicationController
	def profile
		@posts= current_user.posts
		@posts=@posts+current_user.follows_posts+current_user.searched_people_posts+my_friends_posts
		@posts=@posts.uniq
	end
	def search
		@busqueda_param=search_params[:name]
		@busqueda_param=@busqueda_param.split(' ')
		@users=current_user.search(@busqueda_param)
  	@users=@users.uniq
	end

	def search_params
    	params.require(:user).permit(:name,:last_name)
  	end

end
