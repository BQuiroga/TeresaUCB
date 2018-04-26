class ExperiencesController < ApplicationController
	def create
		@new=Experience.new(experiences_params)
		if @new.save
			flash[:success] = "Muy bien! ¿Que otros retos afrontaste?"
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
		@experience=Experience.find(params[:id])
	end
	def update
		@experience=Experience.find(experiences_params_for_edit[:id])
		@experience.update(experiences_params_for_edit)
    redirect_to '/users/curriculum/edit'
	end
	def experiences_params
  		params.require(:experience).permit(:start_date,:resume_id,:end_date,:job_title,:company_name,:key_words,:job_description,:referential,:referential_number,:salary_range,:until_now)
  	end
  	def experiences_params_for_edit
  		params.require(:experience).permit(:id,:job_title,:company_name,:key_words,:job_description,:start_date,:end_date,:referential,:referential_number,:salary_range,:until_now)
  	end
end
