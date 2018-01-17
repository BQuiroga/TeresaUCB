class CoursesController < ApplicationController
	def create
		@new=Course.new(courses_params)
		if @new.save
			flash[:success] = "Wow! ¿Que mas aprendiste?"
		else
			flash[:danger] = "Ha ocurrido un error, por favor intentalo nuevamente"
		end
		if @new.resume.user_id==current_user.id
			redirect_to '/users/curriculum/edit'
		else
			@v='/curriculum/'+@new.resume.user_id.to_s+'/edit'
			redirect_to @v
		end
	end
	def edit
		@course=Course.find(params[:id])
	end
	def update
		@course=Course.find(courses_params_for_edit[:id])
		@course.update(courses_params_for_edit)
		if @course.resume.user_id==current_user.id
    	redirect_to '/users/curriculum/edit'
		else
			@v='/curriculum/'+@course.resume.user_id.to_s+'/edit'
			redirect_to @v
		end
	end
	def courses_params
  		params.require(:course).permit(:date,:resume_id,:name,:given, :workload,:institution)
  	end
  	def courses_params_for_edit
  		params.require(:course).permit(:id,:name,:date,:given, :workload,:institution)
  	end
end
