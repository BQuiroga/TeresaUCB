class PublicationsController < ApplicationController
	def create
		@new=Publication.new(publications_params)
		if current_user.id!=@new.user.id
			throwUnauthorized
			return
		else
		if @new.save
			flash[:success] = "Asombroso! Cuentanos mas de ti"
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
		@publicationTypes=["Articulo","Tesis","Libro","Monografia"]
		@publication=Publication.new
	end
	def edit
		@publication=Publication.find(params[:id])
		if current_user.id!=@publication.user.id
			throwUnauthorized
			return
		else
			@publicationTypes=["Articulo","Tesis","Libro","Monografia"]
		end
	end
	def update
		@publication=Publication.find(publications_params_for_edit[:id])
		if current_user.id!=@publication.user.id
			throwUnauthorized
			return
		else
		@publication.update(publications_params_for_edit)
	  	redirect_to '/users/curriculum/edit'
		end
	end
	def destroy
		@publication = Publication.find(params[:id])
		@publication.destroy
		if @publication.destroy
				redirect_to '/users/curriculum/edit', notice: "Se han guardado tus cambios con éxito!"
		end
	end
	def publications_params
  		params.require(:publication).permit(:name, :resume_id,:publicationType,:date,:location)
  	end
  	def publications_params_for_edit
  		params.require(:publication).permit(:id,:name,:ṕublicationType,:date,:location)
  	end
end
