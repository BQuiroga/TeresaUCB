class Education < ActiveRecord::Base
  belongs_to :resume
  before_create :validate_date
	def validate_date
		start_date<end_date && start_date<Time.now
	end
  def user
    resume=self.resume
    user=resume.user
  end
  def title_list
    list=Array.new
    v=Title.all
    v.each do |title|
      list=list+[title.name]
    end
    list
  end
  def grade(grade)
    if grade[1]!=""
      return "Maestria"
    end
    if grade[2]!=""
      return "Postgrado"
    end
    if grade[3]!=""
      return "Doctorado"
    end
    if grade[0]!=""
      return ["Maestria","Postgrado","Doctorado"]
    end
  end
  def licenciaturas
    result=title_list-postdoctorados-maestrias-doctorados-especialidades
    result=result+["Todos"]
  end
  def especialidades
    result=title_list.select{|x| x.include?("Especialidad")}
    result=result+["Todos"]
  end
  def maestrias
    result=title_list.select{|x| x.include?("Maestria")}+title_list.select{|x| x.include?("Master")}
    result=result+["Todos"]
  end
  def doctorados
    result=title_list.select{|x| x.include?("Doctorado")} + title_list.select{|x| x.include?("Doctor")} + title_list.select{|x| x.include?("Ph ")}
    result=result+["Todos"]
  end
  def postdoctorados
    result=title_list.select{|x| x.include?("Post Doctorado")}
    result=result+["Todos"]
  end
  def diplomados
    result=title_list.select{|x| x.include?("Diplomados")}
    result=result+["Todos"]
  end

  def title_name
    education.try(:title)
  end
  def title_name=(name)
    self.education=Education.find_by(title: name) if name.present?
  end
  def chart_names
    Education.group(:school_name).count.keys
  end
  def users(school)
    educations=Education.where(school_name:school)
    educations.map {|education| education.user}
  end
  def genders(school)
    e=Array.new
    educations=users(school)
    educations.map {|user| user.personal_information.gender}
    # e[0]=educations.count(true)
    # e[1]=educations.count(false)
    # e[2]=educations.count(nil)
    # e
  end
  def registro_academico(grado,licen,maestria,postgrado,doctorado)
    if grado=="Todos"
      edu ="Todos los grados academicos"
      results=Education.all
    else
      edu=[licen,maestria,postgrado,doctorado].join
      if edu=="Todos"
        data=self.grade([licen,maestria,postgrado,doctorado])
        if data.class==Array
          results=Education.where.not(title:data)
        else
          results=Education.where(title:data)
        end
      else
        results=Education.where(title:edu)
      end
    end
    results
  end
  def entre_fechas(inicio,fin,query)
    if inicio=="Invalido" and fin=="Invalido"
      return query
    end
    if (inicio=="Invalido")
      return query.where("end_date < ?",fin)
    end
    if (fin=="Invalido")
      return query.where("end_date > ?",inicio)
    end
    query.where(end_date:inicio..fin)
  end
  def title_detail(title)
    title_list[title]
  end
  def time_range_hash(hash)
    nueva=Hash.new(0)
    hash.each do |item|
      if (item[0].to_i>0 and item[0].to_i<3)
        nueva["meses: 0 - 3"]+=item[1]
      end
      if (item[0].to_i>=3 and item[0].to_i<6)
        nueva["meses: 3 - 6"]+=item[1]
      end
      if (item[0].to_i>=6 and item[0].to_i<9)
        nueva["meses: 6 - 9"]+=item[1]
      end
      if (item[0].to_i>=9 and item[0].to_i<12)
        nueva["meses: 9 - 12"]+=item[1]
      end
      if (item[0].to_i>=12 and item[0].to_i<36)
        nueva["años: 1 a 3"]+=item[1]
      end
      if (item[0].to_i>=36 and item[0].to_i<60)
        nueva["años: 3 a 5"]+=item[1]
      end
      if (item[0].to_i>=60 and item[0].to_i<84)
        nueva["años: 5 a 7"]+=item[1]
      end
      if (item[0].to_i>=84 )
        nueva["pasados 7 años"]+=item[1]
      end
    end
    nueva["Aun no ha egresado"]=hash["Aun no ha egresado"]
    nueva.sort_by {|key,value| key}
  end
end
