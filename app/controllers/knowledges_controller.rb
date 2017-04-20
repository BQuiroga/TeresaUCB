class KnowledgesController < ApplicationController
	def create
		Knowledge.create(knowledges_params)
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
  		params.require(:knowledge).permit(:description,:knowledge_area_id,:resume_id)
  	end
  	def knowledges_params_for_edit
  		params.require(:knowledge).permit(:id,:description)
  	end
end
