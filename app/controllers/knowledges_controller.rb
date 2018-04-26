class KnowledgesController < ApplicationController
	def create
		@new=Knowledge.new(knowledges_params)
		if @new.save
			flash[:success] = "Genial! ¿Que otras cosas mas sabes?"
		else
			flash[:danger] = "Ha ocurrido un error, por favor intentalo nuevamente"
		end
		redirect_to '/users/curriculum/edit'

	end
	def edit
		@knowledge=Knowledge.find(params[:id])
	end
	def update
		@knowledge=Knowledge.find(knowledges_params_for_edit[:id])
		@knowledge.update(knowledges_params_for_edit)
		redirect_to '/users/curriculum/edit'
	end
	def knowledges_params
  		params.require(:knowledge).permit(:description,:area,:resume_id)
  	end
  	def knowledges_params_for_edit
  		params.require(:knowledge).permit(:id,:description,:area)
  	end
end
