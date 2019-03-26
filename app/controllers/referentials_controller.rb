class ReferentialsController < ApplicationController
  def create
    @new=Referential.new(referentials_params)
    if current_user.id!=@new.user.id or current_user.is_director
      throwUnauthorized
      return
    else
  		if @new.save
  			flash[:success] = "Fabuloso! ¿Tienes alguien mas en mente?"
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
    @referential=Referential.new
  end
  def edit
    @referential=Referential.find(params[:id])
    if current_user.id!=@referential.user.id or current_user.is_director
      throwUnauthorized
      return
    else
    end
  end
  def update
    @referential=Referential.find(referentials_params_for_edit[:id])
    if current_user.id!=@referential.user.id or current_user.is_director
      throwUnauthorized
      return
    else
    @referential.update(referentials_params_for_edit)
    redirect_to '/users/curriculum/edit'
  end
  end
  def destroy
    @referential = Referential.find(params[:id])
    @referential.destroy
    if @referential.destroy
        redirect_to '/users/curriculum/edit', notice: "Se han guardado tus cambios con éxito!"
    end
  end
  def referentials_params
      params.require(:referential).permit(:name,:number,:institution,:resume_id)
  end
  def referentials_params_for_edit
      params.require(:referential).permit(:id,:name,:number,:institution)
  end
end
