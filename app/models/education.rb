class Education < ActiveRecord::Base
  belongs_to :resume
  before_create :validate_date
  before_update :validate_date
  self.per_page = 7
	def validate_date
		start_date<end_date && start_date<Time.now
	end
  def capit

  end
  def cato_names
    ["Universidad Catolica Boliviana San Pablo","UCB","UCBSP","Universidad Católica Boliviana 'San Pablo'","Universidad Catolica San Pablo","Univ Catolica"]
  end
  def ingresos
    Education.where(school_name:cato_names)
  end
  def ingresos_en(anio)
    edu=Education.where('extract(year from start_date) =?',anio).where(school_name:cato_names)
    edu
  end
  def numero_ingresos(anio)
    ingresos_en(anio).count
  end
  def numero_ingresos_por(anio,lista)
    lista.where('extract(year from start_date) =?',anio).where(school_name:cato_names).count
  end
  def egresos_en(anio)
    edu=Education.where('extract(year from end_date) =?',anio).where(school_name:cato_names)
    edu
  end
  def numero_egresos_por(anio,lista)
    lista.where('extract(year from end_date) =?',anio).where(school_name:cato_names).count
  end
  def numero_egresos(anio)
    egresos_en(anio).count
  end
  def relacion_acreditacion(gestion)
    if (numero_ingresos(gestion-4)==0)
      relacion="No es posible obtener este dato"
    else
      relacion=numero_egresos(gestion)*100/numero_ingresos(gestion-4)
    end
    relacion
  end
  def relacion_acreditacion_por(gestion,lista)
    if (numero_ingresos_por(gestion-4,lista)==0)
      relacion="No es posible obtener este dato"
    else
      relacion=(numero_egresos_por(gestion,lista)*100.0/numero_ingresos_por(gestion-4,lista)).round(2)
    end
    relacion
  end
  def colleges
    schools=Array.new
    educations=Education.all
    educations.each do |edu|
      schools=schools + [edu.school_name]
    end
    schools=schools.uniq
    schools
  end
  def user
    resume=self.resume
    user=resume.user
    user
  end
  def title_list
    list=Array.new
    v=Title.all
    v.each do |title|
      list=list+[title.name]
    end
    list
  end
  def grades(grade)
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
    result=title_list-postdoctorados-maestrias-doctorados-especialidades-diplomados
    result=result+["Todos"]
  end
  def especialidades
    result=title_list.select{|x| x.include?("Especialidad")}+title_list.select{|x| x.include?("Especialización")}+title_list.select{|x| x.include?("Especializacion")}+title_list.select{|x| x.include?("Especialista")}
    result=result+["Todos"]
  end
  def maestrias
    result=title_list.select{|x| x.include?("Maestria")}+title_list.select{|x| x.include?("Master")}+title_list.select{|x| x.include?("Maestría")}
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
    result=title_list.select{|x| x.include?("Diplomado")}
    result=result+["Todos"]
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
  def users_by_career(school,career)
    educations=Education.where(school_name:school).where("title ~* ?",career)
    educations.map {|education| education.user}
  end
  def users_career(career)
    educations=ingresos.where("title ~* ?",career)
    educations.map {|education| education.user}.uniq
  end
  def genders(school)
    educations=users(school)
    educations.select {|user| (user.personal_information!=nil)}.map {|user| user.personal_information.gender}
  end
  def genders_by_career(school,career)
    educations=users_by_career(school,career)
    educations.select {|user| (user.personal_information!=nil)}.map {|user| user.personal_information.gender}
  end

  def registro_academico(grado,licen,maestria,postgrado,doctorado)
    if grado=="Todos"
      edu ="Todos los grados académicos"
      results=Education.all
    else
      case grado
      when "Todos"
        results=Education.all
      when "Licenciatura"
        if licen =="Todos"
          results = Education.where(title:licenciaturas)
        else
          results=Education.where(title:licen)
        end
      when "Maestria"
        if licen =="Todos"
          results = Education.where(title:maestrias)
        else
          results=Education.where(title:maestria)
        end
      when "Postgrado"
        if licen =="Todos"
          results = Education.where(title:postgrados)
        else
          results=Education.where(title:postgrado)
        end
      when "Doctorado"
        if licen =="Todos"
          results = Education.where(title:doctorados)
        else
          results=Education.where(title:doctorado)
        end
      when "Postdoctorado"
        if licen =="Todos"
          results = Education.where(title:postdoctorados)
        else
          results=Education.where(title:doctorado)
        end
      when "Especialidad"
        if licen =="Todos"
          results = Education.where(title:especialidades)
        else
          results=Education.where(title:postgrado)
        end
      # end
      # edu=[licen,maestria,postgrado,doctorado].join
      # if edu=="Todos"
      #   data=self.grade([licen,maestria,postgrado,doctorado])
      #   if data.class==Array
      #     results=Education.where.not(title:data)
      #   else
      #     results=Education.where(title:data)
      #   end
      # else
      #   results=Education.where(title:edu)
      # end
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
    nueva["Aún no trabaja"]=hash["Aún no trabaja"]
    nueva.sort_by {|key,value| key}
  end
  def cato_titles
    ["Todas las carreras","Bachiller","Antroplogía","Comunicación Social","Derecho",
      "Filosofía y Letras","Psicología","Ingeniería Ambiental",
      "Ingeniería Civil","Ingeniería Industrial","Ingeniería Química",
      "Ingeniería Mecatrónica","Ingeniería de Sistemas","Ingeniería de Telecomunicaciones",
      "Administración de Empresas","Contaduría Pública","Ingeniería Comercial","Ingeniería Financiera"]
  end
  def antropologos
    self.ingresos.where("title ~* ?", "Antropolog")
  end
  def comunicadores
    self.ingresos.where("title ~* ?", "Comunica")
  end
  def filosofos
    self.ingresos.where("title ~* ?", "Filosof")
  end
  def psicologos
    self.ingresos.where("title ~* ?","Psicolog")
  end
  def ambientales
    self.ingresos.where("title ~* ?", "Ambient")
  end
  def civiles
    self.ingresos.where("title ~* ?", "Civil")
  end
  def industriales
    self.ingresos.where("title ~* ?", "Industria")
  end
  def quimicos
    self.ingresos.where("title ~* ?", "Químic")
  end
  def mecatronicos
    self.ingresos.where("title ~* ?","Mecatrónic")
  end
  def sistemas
    self.ingresos.where("title ~* ?", "Sistemas")
  end
  def telecomunicadores
    self.ingresos.where("title ~* ?", "Telecomunicaciones")
  end
  def administradores
    self.ingresos.where("title ~* ?", "Administrador de Empresas")
  end
  def financieros
     Education.where(:school_name=>cato_names).where("title~* ?","Financ")
  end
  def abogados
    Education.where(:title => ["Derecho","Abogado"],:school_name=>cato_names)
  end
  def contadores
    self.ingresos.where("title ~* ?", "Contad")
  end
  def comerciales
    self.ingresos.where("title ~* ?", "Comercial")
  end
  def impacto_de(carrera)
    resumes=carrera.map{|education| education.resume_id}.uniq
    trabajos=Experience.where(resume_id:resumes)
    trabajos.group(:city).count
  end
  def total(carrera)
    todos=impacto_de(carrera)
    cant=0
    todos.keys.each do |pais|
      cant+=todos[pais]
    end
    cant
  end
  def para_porcentaje(lista,pais)
    total=total(lista)
    cantidad=impacto_de(lista)[pais]
    if total!=0
      resp=(cantidad*100.0/total).round(2)
    else
      resp="Aun no se puede obtener este dato"
    end
    resp
  end
  def region_de(carrera)
    todos=impacto_de(carrera)
    r=Hash.new
    r={"Interior"=>0,"Exterior"=>0}
    todos.keys.each do |pais|
      if pais=="Bolivia"
        r["Interior"]+=todos[pais]
      else
        r["Exterior"]+=todos[pais]
      end
    end
    r
  end
  def universitarios
    usuarios=Array.new
    edu=Education.where("school_name ~*?","Universidad").where("end_date>?",Date.today)
    edu.each do |education|
      usuarios.push(education.resume.user)
    end
    usuarios.uniq!
    return usuarios.size
  end
  def titulados
    usuarios=Array.new
    edu=Education.where("school_name ~*?","Universidad").where("end_date<?",Date.today)
    edu.each do |education|
      usuarios.push(education.resume.user)
    end
    usuarios.uniq!
    usuarios.size
  end
  def education_has(list)
    r=Array.new
    list.each do |education|
      r=r+Education.where("title~*?",education)
    end
    r
  end
  def users_of(carrera)
    users=Array.new
    carrera.each do |education|
      users=users+[education.user]
    end
    users=users.uniq
    users
  end
  def time_to_work(list)
    years=Hash.new(0)
    list.each do |user|
      if (user.years_to_first_job==-1 or user.years_to_first_job==-2)
        years["Aun no ha egresado"]+=1
      else
        years[user.years_to_first_job] +=1
      end
      if (user.years_to_first_job==-2)
        years["Aún no trabaja"]+=1
      end
    end
    years
  end
end
