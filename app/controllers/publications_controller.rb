class PublicationsController < ApplicationController
	def create
		Publication.create(publications_params)
    	redirect_to '/users/curriculum/edit'
	end
	def update

	end
	def publications_params
  		params.require(:publication).permit(:name, :resume_id,:publicationType,:date,:location)
  	end
  	def publications_params_for_edit
  		params.require(:publication).permit(:id,:name,:ṕublicationType,:date,:location)
  	end
end
