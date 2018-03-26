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
  def external_edit
    @user=User.find(params[:id])
    @resume=@user.resume
    @personal_info=current_user.personal_information
    @educations=@resume.educations.order(end_date: :desc)
    @experiences=@resume.experiences.order(end_date: :desc)
    @courses = @resume.courses.order(date: :desc)
    @knowledges = @resume.knowledges
    @publications=@resume.publications.order(date: :desc)
    @merits=@resume.merits
    @memberships=@resume.memberships.order(date: :desc)
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
    @educations=@resume.educations.order(end_date: :desc)
    @experiences=@resume.experiences.order(end_date: :desc)
    @courses = @resume.courses.order(date: :desc)
    @knowledges = @resume.knowledges
    @publications=@resume.publications.order(date: :desc)
    @memberships=@resume.memberships.order(date: :desc)
    @languages=@resume.languages
    @referentials=@resume.referentials
    @skills=@resume.skills
      respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "CV.pdf",
          :template => "resumes/external_show.html.erb",
          :layout => 'application'
        end
      end
  end
  def show_pdf
    @resume=current_user.resume
    @merits=@resume.merits
    @user=@resume.user
    @personal_info=current_user.personal_information
    @educations=@resume.educations.order(end_date: :desc)
    @experiences=@resume.experiences.order(end_date: :desc)
    @courses = @resume.courses.order(date: :desc)
    @knowledges = @resume.knowledges
    @publications=@resume.publications.order(date: :desc)
    @memberships=@resume.memberships.order(date: :desc)
    @languages=@resume.languages
    @referentials=@resume.referentials
    @skills=@resume.skills
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "CV.pdf",
        :template => "resumes/show_pdf.html.erb"
      end
    end
  end

  def show_pdf_red
    @resume=current_user.resume
    @merits=@resume.merits
    @user=@resume.user
    @personal_info=current_user.personal_information
    @educations=@resume.educations.order(end_date: :desc)
    @experiences=@resume.experiences.order(end_date: :desc)
    @courses = @resume.courses.order(date: :desc)
    @knowledges = @resume.knowledges
    @publications=@resume.publications.order(date: :desc)
    @memberships=@resume.memberships.order(date: :desc)
    @languages=@resume.languages
    @referentials=@resume.referentials
    @skills=@resume.skills
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "CV.pdf",
        :template => "resumes/show_pdf_red.html.erb"
      end
    end
  end
  def external_show
    @user=User.find(params[:id])
    @resume=@user.resume
    @merits=@resume.merits
    @personal_info=@user.personal_information
  	@educations=@resume.educations.order(end_date: :desc)
  	@experiences=@resume.experiences.order(end_date: :desc)
  	@courses = @resume.courses.order(date: :desc)
    @knowledges = @resume.knowledges
    @publications=@resume.publications.order(date: :desc)
    @memberships=@resume.memberships.order(date: :desc)
    @languages=@resume.languages
    @referentials=@resume.referentials
    @skills=@resume.skills
  end
  def show_modal
    @user=User.find(params[:id])
    @resume=@user.resume
    @merits=@resume.merits
    @personal_info=@user.personal_information
    @educations=@resume.educations.order(end_date: :desc)
    @experiences=@resume.experiences.order(end_date: :desc)
    @courses = @resume.courses.order(date: :desc)
    @knowledges = @resume.knowledges
    @publications=@resume.publications.order(date: :desc)
    @memberships=@resume.memberships.order(date: :desc)
    @languages=@resume.languages
    @referentials=@resume.referentials
    @skills=@resume.skills
    render :layout =>false
  end
end
