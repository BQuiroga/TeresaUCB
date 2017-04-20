class ExperiencesController < ApplicationController
	def create
		Experience.create(experiences_params)
    	redirect_to '/users/curriculum/edit'
	end
	def edit
		@experience=Experience.find(params[:id])
	end
	def update
		@experience=Experience.find(experiences_params_for_edit[:id])
		@experience.update(experiences_params_for_edit)
		redirect_to '/users/curriculum/edit'
	end
	def experiences_params
  		params.require(:experience).permit(:start_date,:resume_id,:end_date,:job_title,:company_name,:key_words,:job_description)
  	end
  	def experiences_params_for_edit
  		params.require(:experience).permit(:id,:job_title,:company_name,:key_words,:job_description)
  	end
end
