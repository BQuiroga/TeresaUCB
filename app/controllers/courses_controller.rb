class CoursesController < ApplicationController
	def create
		@new=Course.new(courses_params)
		if @new.save
			flash[:success] = "Wow! ¿Que mas aprendiste?"
		else
			flash[:danger] = "Ha ocurrido un error, por favor intentalo nuevamente"
		end
    redirect_to '/users/curriculum/edit'
	end
	def edit
		@course=Course.find(params[:id])
	end
	def update
		@course=Course.find(courses_params_for_edit[:id])
		@course.update(courses_params_for_edit)
		redirect_to '/users/curriculum/edit'
	end
	def courses_params
  		params.require(:course).permit(:date,:resume_id,:name,:given, :workload,:institution)
  	end
  	def courses_params_for_edit
  		params.require(:course).permit(:id,:name,:date,:given, :workload,:institution)
  	end
end
