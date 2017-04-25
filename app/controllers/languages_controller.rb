class LanguagesController < ApplicationController
  def create
    Language.create(languages_params)
      redirect_to '/users/curriculum/edit'
  end
  def edit
    @language=Language.find(params[:id])
  end
  def update
    @language=Language.find(languages_params_for_edit[:id])
    @language.update(languages_params_for_edit)
    redirect_to '/users/curriculum/edit'
  end
  def languages_params
      params.require(:language).permit(:name,:skill,:resume_id,:level)
    end
    def languages_params_for_edit
      params.require(:language).permit(:id,:name,:skill,:level)
    end
end
