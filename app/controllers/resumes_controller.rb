class ResumesController < ApplicationController
  
  
  def edit
  	@resume=current_user.resume
  	@personal_info=current_user.personal_information
  	@educations=@resume.educations
  	@experiences=@resume.experiences
  	@courses = @resume.courses
    @knowledges = @resume.knowledges
    @publications=@resume.publications
    @merits=@resume.merits
    @memberships=@resume.memberships
    @publicationTypes=["Articulo","Tesis","Libro","Monografia"]
  end
  def update
  end
  def show
  	@resume=current_user.resume
    @merits=@resume.merits
    @user=@resume.user
  	@personal_info=current_user.personal_information
  	@educations=@resume.educations
  	@experiences=@resume.experiences
  	@courses = @resume.courses
    @knowledges = @resume.knowledges
    @publications=@resume.publications
    @memerships=@resume.memberships
  end
end
