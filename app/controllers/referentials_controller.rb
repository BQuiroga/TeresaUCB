class ReferentialsController < ApplicationController
  def create
    Referential.create(referentials_params)
      redirect_to '/users/curriculum/edit'
  end
  def edit
    @referential=Referential.find(params[:id])
  end
  def update
    @referential=Referential.find(referentials_params_for_edit[:id])
    @referential.update(referentials_params_for_edit)
    redirect_to '/users/curriculum/edit'
  end
  def referentials_params
      params.require(:referential).permit(:name,:number,:institution,:resume_id)
    end
  def referentials_params_for_edit
      params.require(:referential).permit(:id,:name,:number,:institution)
  end
end
