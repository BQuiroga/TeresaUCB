class UsersController < ApplicationController
	layout :resolve_layout
	def resolve_layout
		if index
			"application"
		else
			"application"
		end
	end
	def profile
		@user=current_user
		@belongs=@user.group_managers
		@groups=[]
		@belongs.each do |my_group|
			@group=my_group.group
			@groups=@groups+[@group]
		end
		@posts= current_user.posts
		@posts=@posts+current_user.follows_posts+current_user.searched_people_posts+current_user.my_friends_posts
		@posts=@posts.uniq
	end
	def search
		@busqueda_param=search_params[:name]
		@busqueda_param=@busqueda_param.split(' ')
		@users=current_user.search(@busqueda_param)
  	@users=@users.uniq
	end
	def bloquear
		@user=User.find(params[:id])
		@user.lock_access!({send_instructions: false})
		redirect_to '/users'
	end
	def desbloquear
		@user=User.find(params[:id])
		@user.unlock_access!
		redirect_to '/users'
	end
	def index
		if !current_user.is_administrator
			throwUnauthorized
			return
		else
			@users=User.all
		end
	end
	def reportes_general
		@users=User.all
	end

	def search_params
    	params.require(:user).permit(:name,:last_name)
  	end

end
