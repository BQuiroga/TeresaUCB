class MeritsController < ApplicationController
	def create
		@new=Merit.new(merits_params)
		if current_user.id!=@new.user.id
			throwUnauthorized
			return
		else
		if @new.save
			flash[:success] = "Fantastico! Dinos mas"
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
		@merit=Merit.new
	end
	def edit
		@merit=Merit.find(params[:id])
		if current_user.id!=@merit.user.id
			throwUnauthorized
			return
		else
		end
	end
	def update
		@merits=Merit.find(merits_params_for_edit[:id])
		if current_user.id!=@merits.user.id
			throwUnauthorized
			return
		else
		@merits.update(merits_params_for_edit)
		redirect_to '/users/curriculum/edit'
		end
	end
	def destroy
		@merit= Merit.find(params[:id])
		@merit.destroy
		if @merit.destroy
				redirect_to '/users/curriculum/edit', notice: "Se han guardado tus cambios con éxito!"
		end
	end
	def merits_params
  		params.require(:merit).permit(:name, :resume_id,:date)
  	end
  	def merits_params_for_edit
  		params.require(:merit).permit(:id,:name,:date)
  	end
end
