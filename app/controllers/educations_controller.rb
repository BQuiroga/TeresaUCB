class EducationsController < ApplicationController
	def create
		@new=Education.new(educations_params)
		if @new.save
			flash[:success] = "Asombroso! Cuentanos mas"
		else
			flash[:danger] = "Ha ocurrido un error, por favor intentalo nuevamente"
		end
		if @new.resume.user_id==current_user.id
			redirect_to '/users/curriculum/edit'
		else
			redirect_to '/curriculum/:@new.resume.user_id/edit'
		end
	end
	def edit
		@education=Education.find(params[:id])
		@titles=Title.all
		@newA=Array.new
		@title_list=Array.new
		@titles.each do |title|
			@newA=@newA+[title.name]
		end
		@title_list=@newA
	end
	def update
		@education=Education.find(educations_params_for_edit[:id])
		@education.update(educations_params_for_edit)
		if @new.resume.user_id=current_user.id
			redirect_to '/users/curriculum/edit'
		else
			redirect_to '/curriculum/:@new.resume.user_id/edit'
		end
	end
	def educations_params
  		params.require(:education).permit(:start_date,:resume_id,:end_date,:school_name,:title,:description)
  	end
  	def educations_params_for_edit
  		params.require(:education).permit(:id,:school_name,:title,:description,:end_date,:start_date)
  	end
end
