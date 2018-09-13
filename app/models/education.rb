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
    ["Universidad Catolica Boliviana San Pablo","UCB","UCBSP","Universidad Católica Boliviana 'San Pablo'"]
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
    if (numero_ingresos(gestion-5)==0)
      relacion="No es posible obtener este dato"
    else
      relacion=numero_egresos(gestion)*100/numero_ingresos(gestion-5)
    end
    relacion
  end
  def relacion_acreditacion_por(gestion,lista)
    if (numero_ingresos_por(gestion-5,lista)==0)
      relacion="No es posible obtener este dato"
    else
      relacion=numero_egresos_por(gestion,lista)*100/numero_ingresos_por(gestion-5,lista)
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
    self.ingresos.where("title ~* ?", "Antropolog")
  end
  def filosofos
    self.ingresos.where("title ~* ?", "Filosofía")
  end
  def psicologos
    self.ingresos.where("title ~* ?","Psicología")
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
    self.ingresos.where("title ~* ?", "Administración de Empresas")
  end
  def financieros
     Education.where(:title => ["Financier","Finanzas"],:school_name=>cato_names)
  end
  def abogados
    Education.where(:title => ["Derecho","Abogad"],:school_name=>cato_names)
  end
  def contadores
    self.ingresos.where("title ~* ?", "Contador")
  end
  def comerciales
    self.ingresos.where("title ~* ?", "Comercial")
  end
end
