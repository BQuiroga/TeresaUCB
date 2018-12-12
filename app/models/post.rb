class Post < ActiveRecord::Base
  default_scope -> {order(created_at: :desc)}
  has_many :pictures,:dependent=>:destroy
  has_many :notifications,:dependent=>:destroy
  belongs_to :user
  has_many :likes
  def new_post_body(search_params)
    self.body=job_offer(search_params[:titulo],
                                search_params[:post_grado],
                                search_params[:horas],
                                search_params[:ciudad],
                                search_params[:idiomas],
                                search_params[:cargo],
                                search_params[:experiencia],
                                search_params[:habilidades],
                                search_params[:phone],
                                search_params[:contact])
    self.user_id=search_params[:user_id]
    self.requiring=true
  end
  def new_post_body_personal(personal_params)
    self.body=personal_offer(personal_params[:name],personal_params[:comment],personal_params[:contact],personal_params[:phone])
    self.user_id=personal_params[:user_id]
    self.requiring=true
  end
  def user_name
    user=self.user
    user.name
  end

  def search_params_count(postgrados,educaciones,experiencias,conocimientos,idiomas)
    count=0
    if postgrados.size>0
      count+=1
    end
    if educaciones.size>0
      count+=1
    end
    if experiencias.size>0
      count+=1
    end
    if conocimientos.size>0
      count+=1
    end
    if idiomas.size>0
      count+=1
    end
    count
  end
  def job_offer(titulo,postgrado,horas,ciudad,idiomas,cargo,experiencia,habilidades,fijo,contact)
    resp="Estamos buscando personal, con las siguientes caracteristicas: \n"
    if titulo.size>0
      resp+="  Titulo Academico: "+titulo+"\n"
    end
    if postgrado.size>0
      resp+="  Post Grado: "+postgrado+"\n"
    end
    if ciudad.size>0
      resp+="  De la ciudad: "+ciudad+"\n"
    end
    if idiomas.size>0
      resp+="  Con dominio en los siguientes idiomas: "+idiomas+"\n"
    end
    if cargo.size>0
      resp+="  Que haya ocupado el cargo de: "+cargo+"\n"
    end
    if habilidades.size>0
      resp+="  Con las siguientes habilidades: "+habilidades+"\n"
    end
    if experiencia.size>0
      resp+="  Con experiencia en areas de: "+experiencia+"\n"
    end
    if !contact
      contact=""
    end
    if !fijo
      fijo=""
    end
    resp+= "  Si tu curriculum cumple con los anteriores requisitos, comunicate con nosotros\n"+ "Contactacte con: "+contact+"\n a este numero de referencia: " +fijo+"\n"
    resp
  end
  def personal_offer(name,comment,contact,fijo)
    resp="De: "+name+"\n"+comment+"\nSi te interesa un puesto en nuestra empresa, porfavor contactate con nuestro personal\n"
    if contact.size>0
      resp=resp+"Contactate con: "+contact
    end
    if fijo.size>0
      resp=resp+"\n a este número de referencia: "+fijo+"\n"
    end
    resp
  end
  def send_notice_mail(user)
    UserMailer.notify_email(user).deliver_now!
  end
end
