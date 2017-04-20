class MeritsController < ApplicationController
	def create
		Merit.create(merits_params)
    	redirect_to '/users/curriculum/edit'
	end
	def edit
		@merit=Merit.find(params[:id])
	end
	def update
		@merits=Merit.find(merits_params_for_edit[:id])
		@merits.update(merits_params_for_edit)
		redirect_to '/users/curriculum/edit'
	end
	def merits_params
  		params.require(:merit).permit(:name, :resume_id,:date)
  	end
  	def merits_params_for_edit
  		params.require(:merit).permit(:id,:name,:date)
  	end
end
