class EducationsController < ApplicationController
	def create
		@new=Education.new(educations_params)
		if current_user.id!=@new.user.id
			throwUnauthorized
			return
		else
			if @new.save
				flash[:success] = "Asombroso! Cuentanos mas"
			else
				flash[:danger] = "Ha ocurrido un error, por favor intentalo nuevamente"
			end
			@resume=current_user.resume
			respond_to do |f|
				f.html {redirect_to '/users/curriculum/edit' }
				f.js {redirect_to '/users/curriculum/edit'}
			end
		end
	end
	def new
		@education=Education.new
		@titles=Title.all
		@newA=Array.new
		@title_list=Array.new
		@titles.each do |title|
			@newA=@newA+[title.name]
		end
		@title_list=@newA
	end

	def index
		@resume=current_user.resume
		@educations=@resume.educations
		respond_to do |f|
			f.html
			f.json
		end
	end

	def edit
		@education=Education.find(params[:id])
		if current_user.id!=@education.user.id
			throwUnauthorized
			return
		else
			@titles=Title.all
			@newA=Array.new
			@title_list=Array.new
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
		@education=Education.find(educations_params_for_edit[:id])
		if !current_user.id==@education.user.id
			throwUnauthorized
			return
		else
		@education.update(educations_params_for_edit)
			redirect_to '/users/curriculum/edit'
		end
	end
	def destroy
		@education = Education.find(params[:id])
		@education.destroy
		if @education.destroy
				redirect_to '/users/curriculum/edit', notice: "Se han guardado tus cambios con éxito!"
		end
	end
	def educations_params
  		params.require(:education).permit(:start_date,:resume_id,:end_date,:school_name,:title,:description)
  	end
  	def educations_params_for_edit
  		params.require(:education).permit(:id,:school_name,:title,:description,:end_date,:start_date)
  	end
end
