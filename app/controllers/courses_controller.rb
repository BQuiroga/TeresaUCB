class CoursesController < ApplicationController
	def create
		Course.create(courses_params)
    	redirect_to '/users/curriculum/edit'
	end
	def edit
		@course=Course.find(params[:id])
		@tu="no manches"
	end
	def update
		@course=Course.find(courses_params_for_edit[:id])
		@course.update(courses_params_for_edit)
		redirect_to '/users/curriculum/edit'
	end
	def courses_params
  		params.require(:course).permit(:date,:resume_id,:name,:given)
  	end
  	def courses_params_for_edit
  		params.require(:course).permit(:id,:name,:date,:given)
  	end
end
