class SkillsController < ApplicationController
  def create
    @new=Skill.new(skills_params)
    if current_user.id!=@new.user.id
      throwUnauthorized
      return
    else
		if @new.save
			flash[:success] = "Perfecto! ¿Que otras habilidades adquiriste?"
		else
			flash[:danger] = "Ha ocurrido un error, por favor intentalo nuevamente"
		end
    redirect_to '/users/curriculum/edit'
  end
	end
  def edit
    @skill=Skill.find(params[:id])
    if current_user.id!=@skill.user.id
      throwUnauthorized
      return
    else
    end
  end
  def update
    @skill=Skill.find(skills_params_for_edit[:id])
    if current_user.id!=@skill.user.id
      throwUnauthorized
      return
    else
      @skill.update(skills_params_for_edit)
    	redirect_to '/users/curriculum/edit'
    end
	 end
  def skills_params
      params.require(:skill).permit(:name, :resume_id,:description)
    end
    def skills_params_for_edit
      params.require(:skill).permit(:id,:description)
    end
end
