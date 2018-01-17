class PublicationsController < ApplicationController
	def create
		@new=Publication.new(publications_params)
		if @new.save
			flash[:success] = "Asombroso! Cuentanos mas de ti"
		else
			flash[:danger] = "Ha ocurrido un error, por favor intentalo nuevamente"
		end
		if @new.resume.user_id==current_user.id
    	redirect_to '/users/curriculum/edit'
		else
			@v='/curriculum/'+@new.resume.user_id.to_s+'/edit'
			redirect_to @v
		end	end
	def edit
		@publication=Publication.find(params[:id])
		@publicationTypes=["Articulo","Tesis","Libro","Monografia"]
	end
	def update
		@publication=Publication.find(publications_params_for_edit[:id])
		@publication.update(publications_params_for_edit)
		if @publication.resume.user_id==current_user.id
    	redirect_to '/users/curriculum/edit'
		else
			@v='/curriculum/'+@publication.resume.user_id.to_s+'/edit'
			redirect_to @v
		end	end
	def publications_params
  		params.require(:publication).permit(:name, :resume_id,:publicationType,:date,:location)
  	end
  	def publications_params_for_edit
  		params.require(:publication).permit(:id,:name,:ṕublicationType,:date,:location)
  	end
end
