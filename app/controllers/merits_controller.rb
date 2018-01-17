class MeritsController < ApplicationController
	def create
		@new=Merit.new(merits_params)
		if @new.save
			flash[:success] = "Fantastico! Dinos mas"
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
		@merit=Merit.find(params[:id])
	end
	def update
		@merits=Merit.find(merits_params_for_edit[:id])
		@merits.update(merits_params_for_edit)
		if @merits.resume.user_id==current_user.id
    	redirect_to '/users/curriculum/edit'
		else
			@v='/curriculum/'+@merits.resume.user_id.to_s+'/edit'
			redirect_to @v
		end	end
	def merits_params
  		params.require(:merit).permit(:name, :resume_id,:date)
  	end
  	def merits_params_for_edit
  		params.require(:merit).permit(:id,:name,:date)
  	end
end
