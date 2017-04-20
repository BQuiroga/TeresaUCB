class PublicationsController < ApplicationController
	def create
		Publication.create(publications_params)
    	redirect_to '/users/curriculum/edit'
	end
	def edit
		@publication=Publication.find(params[:id])
		@publicationTypes=["Articulo","Tesis","Libro","Monografia"]
	end
	def update
		@publication=Publication.find(publications_params_for_edit[:id])
		@publication.update(publications_params_for_edit)
		redirect_to '/users/curriculum/edit'
	end
	def publications_params
  		params.require(:publication).permit(:name, :resume_id,:publicationType,:date,:location)
  	end
  	def publications_params_for_edit
  		params.require(:publication).permit(:id,:name,:ṕublicationType,:date,:location)
  	end
end
