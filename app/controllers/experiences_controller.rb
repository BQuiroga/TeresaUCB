class ExperiencesController < ApplicationController
	def create
		Experience.create(experiences_params)
    	redirect_to '/users/curriculum/edit'
	end
	def update

	end
	def experiences_params
  		params.require(:experience).permit(:start_date,:resume_id,:end_date,:job_title,:company_name,:key_words,:job_description)
  	end
  	def experiences_params_for_edit
  		params.require(:experience).permit(:id,:job_title,:company_name,:key_words,:job_description)
  	end
end
