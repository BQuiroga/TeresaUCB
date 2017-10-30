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
    v=Hash.new
    v={"Abogado"=>[],
      "Administracion"=>["Escolar","Internacional", "Publica","y Direccion de Empresas","de Empresas"],
      "Agronomia"=>[],
      "Arquitecto"=>[],
     "Artesano"=>[],
     "Auditor"=>[],
     "Auxiliar"=>["Contabilidad","de Oficina"],
     "Ayudante de Gerencia"=>[],
     "Bachiller"=>["En Humanidades"],
     "Bachillerato Internacional"=>[],
     "Bibliotecologo"=>[],
     "Biologo"=>[],
     "Bioquimico"=>[]
   }
    v
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
  def title_detail(title)
    title_list[title]
  end

end
