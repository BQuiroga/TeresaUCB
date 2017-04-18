class KnowledgesController < ApplicationController
	def create
		Knowledge.create(knowledges_params)
    	redirect_to '/users/curriculum/edit'
	end
	def update

	end
	def knowledges_params
  		params.require(:knowledge).permit(:description,:knowledge_area_id)
  	end
  	def knowledges_params_for_edit
  		params.require(:knowledge).permit(:id,:description)
  	end
end
