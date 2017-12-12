class ResumesController < ApplicationController
  layout :resolve_layout
  def resolve_layout
      "application"
  end
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
    @skills=@resume.skills
    @publicationTypes=["Articulo","Tesis","Libro","Monografia"]
    @titles=Title.all
    @newA=Array.new
    @title_list=Array.new
    @titles.each do |title|
      @newA=@newA+[title.name]
    end
    @title_list=@newA
      @newA=Array.new
    @degree_list=Degree.all.each do |degree|
      @newA=@newA+[degree.name]
    end
    @degree_list=@newA
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
    @skills=@resume.skills
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
    @skills=@resume.skills
  end
end
