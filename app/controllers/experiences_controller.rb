class ExperiencesController < ApplicationController
	def create
		@new=Experience.new(experiences_params)
		if current_user.id!=@new.user.id
			throwUnauthorized
			return
		else
		if @new.save
			flash[:success] = "Muy bien! ¿Que otros retos afrontaste?"
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
		@experience=Experience.new
	end
	def edit
		@experience=Experience.find(params[:id])
		if current_user.id!=@experience.user.id
			throwUnauthorized
			return
		else
		end
	end
	def update
		@experience=Experience.find(experiences_params_for_edit[:id])
		if current_user.id!=@experience.user.id
			throwUnauthorized
			return
		else
			@experience.update(experiences_params_for_edit)
    	redirect_to '/users/curriculum/edit'
		end
	end
	def destroy
		@experience = Experience.find(params[:id])
		@experience.destroy
		if @experience.destroy
				redirect_to '/users/curriculum/edit', notice: "Se han guardado tus cambios con éxito!"
		end
	end
	def experiences_params
  		params.require(:experience).permit(:start_date,:resume_id,:end_date,:job_title,:company_name,:key_words,:job_description,:referential,:referential_number,:salary_range,:until_now,:in_my_charge)
  	end
  	def experiences_params_for_edit
  		params.require(:experience).permit(:id,:job_title,:company_name,:key_words,:job_description,:start_date,:end_date,:referential,:referential_number,:salary_range,:until_now,:in_my_charge)
  	end
end
