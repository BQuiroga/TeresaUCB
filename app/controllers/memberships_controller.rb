class MembershipsController < ApplicationController
	def create
		Membership.create(memberships_params)
    	redirect_to '/users/curriculum/edit'
	end
	def update

	end
	def memberships_params
  		params.require(:membership).permit(:name, :resume_id,:organization,:date)
  	end
  	def memberships_params_for_edit
  		params.require(:membership).permit(:id,:name,:organization,:date)
  	end
end
