class LanguagesController < ApplicationController
  def create
    @new=Language.new(languages_params)
		if @new.save
			flash[:success] = "Admirable! cuentanos mas!"
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
    @language=Language.find(params[:id])
  end
  def update
    @language=Language.find(languages_params_for_edit[:id])
    @language.update(languages_params_for_edit)
    if @language.resume.user_id==current_user.id
    	redirect_to '/users/curriculum/edit'
		else
			@v='/curriculum/'+@language.resume.user_id.to_s+'/edit'
			redirect_to @v
		end  end
  def languages_params
      params.require(:language).permit(:name,:skill,:resume_id,:level)
    end
    def languages_params_for_edit
      params.require(:language).permit(:id,:name,:skill,:level)
    end
end
