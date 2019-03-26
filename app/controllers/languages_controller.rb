class LanguagesController < ApplicationController
  def create
    @new=Language.new(languages_params)
    if current_user.id!=@new.user.id or current_user.is_director
      throwUnauthorized
      return
    else
      if @new.save
		   flash[:success] = "Admirable! cuentanos mas!"
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
    @language=Language.new
  end
  def edit
    @language=Language.find(params[:id])
    if current_user.id!=@language.user.id or current_user.is_director
      throwUnauthorized
      return
    else
    end
  end
  def update
    @language=Language.find(languages_params_for_edit[:id])
    if current_user.id!=@language.user.id or current_user.is_director
      throwUnauthorized
      return
    else
      @language.update(languages_params_for_edit)
      redirect_to '/users/curriculum/edit'
    end
	end
  def destroy
    @language = Language.find(params[:id])
    @language.destroy
    if @language.destroy
        redirect_to '/users/curriculum/edit', notice: "Se han guardado tus cambios con éxito!"
    end
  end
  def languages_params
      params.require(:language).permit(:name,:skill,:resume_id,:level)
    end
    def languages_params_for_edit
      params.require(:language).permit(:id,:name,:skill,:level)
    end
end
