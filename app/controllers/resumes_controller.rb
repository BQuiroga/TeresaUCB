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
    @languages=@resume.languages
    @referentials=@resume.referentials
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
    @memberships=@resume.memberships
    @languages=@resume.languages
    @referentials=@resume.referentials
  end
  def external_show
    @user=User.find(params[:id])
    @resume=@user.resume
    @merits=@resume.merits
    @personal_info=@user.personal_information
  	@educations=@resume.educations
  	@experiences=@resume.experiences
  	@courses = @resume.courses
    @knowledges = @resume.knowledges
    @publications=@resume.publications
    @memberships=@resume.memberships
    @languages=@resume.languages
    @referentials=@resume.referentials
  end
end
