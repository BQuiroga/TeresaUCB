class CoursesController < ApplicationController
	def create
		Course.create(courses_params)
    	redirect_to '/users/curriculum/edit'
	end
	def update

	end
	def courses_params
  		params.require(:course).permit(:date,:resume_id,:name)
  	end
  	def courses_params_for_edit
  		params.require(:course).permit(:id,:name,:date)
  	end
end
