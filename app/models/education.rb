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
  def title_detail(title)
    title_list[title]
  end
  
end
