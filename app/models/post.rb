class Post < ActiveRecord::Base
  default_scope -> {order(created_at: :desc)}
  has_many :pictures
  has_many :notifications
  belongs_to :user
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
    if titulo
      resp+="  Titulo Academico: "+titulo+"\n"
    end
    if postgrado
      resp+="  Post Grado: "+postgrado+"\n"
    end
    if ciudad
      resp+="  De la ciudad: "+ciudad+"\n"
    end
    if idiomas
      resp+="  Con dominio en los siguientes idiomas: "+idiomas+"\n"
    end
    if cargo
      resp+="  Que haya ocupado el cargo de: "+cargo+"\n"
    end
    if habilidades
      resp+="  Con las siguientes habilidades: "+habilidades+"\n"
    end
    if experiencia
      resp+="  Con experiencia en areas de: "+experiencia+"\n"
    end
    resp+= "  Si tu curriculum cumple con los anteriores requisitos, comunicate con nosotros\n"+ "Contactacte con: "+contact+" a este numero de referencia: " +fijo+"\n"
    resp
  end
  def send_notice_mail(user)
    UserMailer.notify_email(user).deliver_now!
  end
end
