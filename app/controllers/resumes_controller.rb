class ResumesController < ApplicationController
  
  def edit
  	@resume=current_user.resume
  	@personal_info=current_user.personal_information
  	@educations=@resume.educations
  	@experiences=@resume.experiences

  end
  def update
  end
end
