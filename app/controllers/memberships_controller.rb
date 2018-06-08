class MembershipsController < ApplicationController
	def create
		@new=Membership.new(memberships_params)
		if current_user.id!=@new.user.id
			throwUnauthorized
			return
		else
		if @new.save
			flash[:success] = "Asombroso! ¿En que otros grupos mas formas parte?"
		else
			flash[:danger] = "Ha ocurrido un error, por favor intentalo nuevamente"
		end
		redirect_to '/users/curriculum/edit'
	end
	end
	def edit
		@membership=Membership.find(params[:id])
		if current_user.id!=@membership.user.id
			throwUnauthorized
			return
		else
		end
	end
	def update
		@membership=Membership.find(memberships_params_for_edit[:id])
		if current_user.id!=@membership.user.id
			throwUnauthorized
			return
		else
		@membership.update(memberships_params_for_edit)
		redirect_to '/users/curriculum/edit'
	end
	end
	def memberships_params
  		params.require(:membership).permit(:name, :resume_id,:organization,:date)
  	end
  	def memberships_params_for_edit
  		params.require(:membership).permit(:id,:name,:organization,:date)
  	end
end
