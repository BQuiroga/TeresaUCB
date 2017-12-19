class SkillsController < ApplicationController
  def create
    @new=Skill.new(skills_params)
		if @new.save
			flash[:success] = "Perfecto! ¿Que otras habilidades adquiriste?"
		else
			flash[:danger] = "Ha ocurrido un error, por favor intentalo nuevamente"
		end
      redirect_to '/users/curriculum/edit'
  end
  def edit
    @skill=Skill.find(params[:id])
  end
  def update
    @skill=Skill.find(skills_params_for_edit[:id])
    @skill.update(skills_params_for_edit)
    redirect_to '/users/curriculum/edit'
  end
  def skills_params
      params.require(:skill).permit(:name, :resume_id,:description)
    end
    def skills_params_for_edit
      params.require(:skill).permit(:id,:description)
    end
end
