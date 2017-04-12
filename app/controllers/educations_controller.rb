class EducationsController < ApplicationController
	def create
		Education.create(educations_params)
    	redirect_to '/users/curriculum/edit'
	end
	def update

	end
	def educations_params
  		params.require(:education).permit(:start_date,:resume_id,:end_date,:school_name,:title,:description)
  	end
  	def educations_params_for_edit
  		params.require(:education).permit(:id,:address,:phone,:cellphone,:birthdate)
  	end
end
