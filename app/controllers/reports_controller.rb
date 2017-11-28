class ReportsController < ApplicationController
  @@r=Education.new
  def new
    @gradol=report_params[:grado_licenciatura]
    @gradom=report_params[:grado_maestria]
    @gradop=report_params[:grado_postgrado]
    @gradod=report_params[:grado_doctorado]
    @grado =report_params[:grado]
    @fecha1=params[:report]
    @genero=report_params[:genero]
    if(@fecha1["fecha_inicio(1i)"].to_i>0 and @fecha1["fecha_inicio(2i)"].to_i>0 and @fecha1["fecha_inicio(3i)"].to_i>0 )
      @fecha_inicio=Date.new @fecha1["fecha_inicio(1i)"].to_i,@fecha1["fecha_inicio(2i)"].to_i,@fecha1["fecha_inicio(3i)"].to_i
    else
      @fecha_inicio="Invalido"
    end
    if ( @fecha1["fecha_fin(1i)"].to_i>0 and @fecha1["fecha_fin(2i)"].to_i>0 and @fecha1["fecha_fin(3i)"].to_i>0)
      @fecha_fin=Date.new  @fecha1["fecha_fin(1i)"].to_i,@fecha1["fecha_fin(2i)"].to_i,@fecha1["fecha_fin(3i)"].to_i
    else
      @fecha_fin="Invalido"
    end
    @results=@@r.registro_academico(@grado,@gradol,@gradom,@gradop,@gradod)
    @results=@@r.entre_fechas(@fecha_inicio,@fecha_fin,@results)
    @users=Array.new
    if @results
      @results.each do |edu|
        @users = [edu.user]+@users
      end
      if @users.size>1
        @users=@users.uniq
      end
      if @genero!="Ambos"
        @users=@users.select{|x| x.gender==@genero}
      end
    end
    @user_ids=@users.map{|user| user.resume.id}
    @results=@results.where(resume_id:@user_ids)
    @data_graphic= @results.group(:title).count
  end



  def users_by_date
    @date_users=User.group_by_month(:created_at).count
  end
  def users_by_university
    @university_users=Education.where("end_date < ?", Date.today).group(:school_name).count
  end
  def students_by_career
    @catolica_users=Education.where("end_date < ?", Date.today).where(school_name:"Universidad Catolica San Pablo")
		@career_users=@catolica_users.group(:title).count
  end
  def users_by_gender
    @info_charts=Hash.new
    @personal_by_gender=PersonalInformation.group(:gender).count
    @info_charts={"Hombres"=>@personal_by_gender[true],"Mujeres"=>@personal_by_gender[false],"Empresas"=>@personal_by_gender[nil]}
  end
  def by_gender_university
    @perso=Education.new
    @used_genders=Hash.new
    @used_schools=@perso.chart_names
    @used_schools.each do |school|
      @used_genders[school]=@perso.genders(school)
    end
		@data=Array.new(@used_schools.size)
		i=0
    @used_genders.each do |gender|
      @data[i]={name:gender[0], data:[["Hombres",gender[1].count(true)],["Mujeres",gender[1].count(false)],["Empresas",gender[1].count(nil)]]}
      i+=1
    end
  end
  def by_ciuu
    @companies_by_code=CompanyInformation.group(:ciu_code_id).count
    @companies_names=Hash.new
    @companies_by_code.each do |c|
      @companies_names[CiuCode.find(c[0]).description]=c[1]
    end
  end
  def by_salary_range
    @salaries=Experience.all.group(:salary_range).count
  end
  def by_time_to_work
    @users=User.all
    @years=Hash.new(0)
    @users.where(company:false).each do |u|
      if (u.years_to_first_job==-1)
        @years["Aun no ha egresado"]+=1
      else
        @years[u.years_to_first_job] +=1
      end
    end
  end
  def time_in_job
    @experiences=Experience.all
    @jobs_time=Hash.new(0)
    @experiences.each do |e|
      if (e.time_in_job==-1)
        @jobs_time["Continua trabajando"]+=1
      else
        @jobs_time[e.time_in_job] +=1
      end
    end
  end
  def with_postgrade
    @educations=Education.where("end_date < ?", Date.today)
    @egresados=@educations.where(title: "Postgrado")
    @data=@egresados.group(:title).count
    @ids=[]
    @egresados.each do |edu|
      @ids=@ids+[edu.resume_id]
    end
    @ids=@ids.uniq
    @users=Array.new
    if @egresados
      @ids.each do |id|
        @users=@users + [Resume.find(id).user]
      end
    end
  end

  def report_params
    params.require(:report).permit(:grado_licenciatura,:grado_postgrado,:grado_maestria,:grado_doctorado,:grado,:fecha_inicio,:fecha_fin,:genero)
  end
end
