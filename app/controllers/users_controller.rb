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

	def search
		@users=[]
		@busqueda_param=search_params[:name]
		@busqueda_param=@busqueda_param.split(' ')
		@busqueda_param.each do |criterio|
  			@user = User.where(name: criterio)
  			@users = @users+ @user
  			@user = User.where(last_name: criterio)
  			@users=@users+@user
  		end
  		@users=@users.uniq
	end
 	def update
		current_user.update(profile_params)
    	redirect_to '/users/profile'
    end
	def search_params
    	params.require(:user).permit(:name, :avatar, :last_name)
  	end

  	def profile_params
    	params.permit(:avatar)
  	end



end
