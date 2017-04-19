class MeritsController < ApplicationController
	def create
		Merit.create(merits_params)
    	redirect_to '/users/curriculum/edit'
	end
	def update

	end
	def merits_params
  		params.require(:merit).permit(:name, :resume_id,:date)
  	end
  	def merits_params_for_edit
  		params.require(:merit).permit(:id,:name,:date)
  	end
end
