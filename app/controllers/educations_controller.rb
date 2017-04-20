class EducationsController < ApplicationController
	def create
		Education.create(educations_params)
    	redirect_to '/users/curriculum/edit'
	end
	def edit
		@education=Education.find(params[:id])
	end
	def update
		@education=Education.find(educations_params_for_edit[:id])
		@education.update(educations_params_for_edit)
		redirect_to '/users/curriculum/edit'
	end
	def educations_params
  		params.require(:education).permit(:start_date,:resume_id,:end_date,:school_name,:title,:description)
  	end
  	def educations_params_for_edit
  		params.require(:education).permit(:id,:school_name,:title,:description,:end_date,:start_date)
  	end
end
