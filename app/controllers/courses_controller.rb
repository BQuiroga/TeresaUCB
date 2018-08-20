class CoursesController < ApplicationController
	def create
		@new=Course.new(courses_params)
		if current_user.id!=@new.user.id
			throwUnauthorized
			return
		else
		if @new.save
			flash[:success] = "Wow! ¿Que mas aprendiste?"
		else
			flash[:danger] = "Ha ocurrido un error, por favor intentalo nuevamente"
		end
		redirect_to '/users/curriculum/edit'
		end
	end
	def edit
		@course=Course.find(params[:id])
		puts current_user.id
		puts @course.user.id
		if current_user.id!=@course.user.id
			throwUnauthorized
			return
		else
		end
	end
	def update
		@course=Course.find(courses_params_for_edit[:id])
		if current_user.id!=@course.user.id
			throwUnauthorized
			return
		else
		@course.update(courses_params_for_edit)
	 	redirect_to '/users/curriculum/edit'
	end
	end
	def destroy
		@course = Course.find(params[:id])
		@course.destroy
		if @course.destroy
				redirect_to '/users/curriculum/edit', notice: "Se han guardado tus cambios con éxito!"
		end
	end
	def courses_params
  		params.require(:course).permit(:date,:resume_id,:name,:given, :workload,:institution)
  	end
  	def courses_params_for_edit
  		params.require(:course).permit(:id,:name,:date,:given, :workload,:institution)
  	end
end
