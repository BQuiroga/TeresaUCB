class CoursesController < ApplicationController
	def create
		@new=Course.new(courses_params)
		if current_user.id!=@new.user.id or current_user.is_director
			throwUnauthorized
			return
		else
		if @new.save
			flash[:success] = "Wow! ¿Que mas aprendiste?"
		else
			flash[:danger] = "Ha ocurrido un error, por favor intentalo nuevamente"
		end
		@resume=current_user.resume
		respond_to do |f|
			f.html {}
			f.js {}
		end
		end
	end
	def new
		@course=Course.new
	end
	def edit
		@course=Course.find(params[:id])
		puts current_user.id
		puts @course.user.id
		@education=Education.new
		if current_user.id!=@course.user.id or current_user.is_director
			throwUnauthorized
			return
		else
			@titles=Title.all
			@newA=Array.new
			@title_list=Array.new
			@schools=@education.colleges
			@titles.each do |title|
				@newA=@newA+[title.name]
			end
			@title_list=@newA
			respond_to do |f|
				f.html
				f.json
			end
		end
	end
	def update
		@course=Course.find(courses_params_for_edit[:id])
		if current_user.id!=@course.user.id or current_user.is_director
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
