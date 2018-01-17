class ReferentialsController < ApplicationController
  def create
    @new=Referential.new(referentials_params)
		if @new.save
			flash[:success] = "Fabuloso! ¿Tienes alguien mas en mente?"
		else
			flash[:danger] = "Ha ocurrido un error, por favor intentalo nuevamente"
		end
    if @new.resume.user_id==current_user.id
    	redirect_to '/users/curriculum/edit'
		else
			@v='/curriculum/'+@new.resume.user_id.to_s+'/edit'
			redirect_to @v
		end  end
  def edit
    @referential=Referential.find(params[:id])
  end
  def update
    @referential=Referential.find(referentials_params_for_edit[:id])
    @referential.update(referentials_params_for_edit)
    if @referential.resume.user_id==current_user.id
    	redirect_to '/users/curriculum/edit'
		else
			@v='/curriculum/'+@referential.resume.user_id.to_s+'/edit'
			redirect_to @v
		end
  end
  def referentials_params
      params.require(:referential).permit(:name,:number,:institution,:resume_id)
    end
  def referentials_params_for_edit
      params.require(:referential).permit(:id,:name,:number,:institution)
  end
end
