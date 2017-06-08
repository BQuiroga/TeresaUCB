class Post < ActiveRecord::Base
  default_scope -> {order(created_at: :desc)}
  has_many :pictures
  has_many :notifications
  belongs_to :user

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
    resp+= "  Si tu curriculum cumple con los anteriores requisitos, comunicate con nosotros\n"+ "Contactacte con: "+contact+"a este numero de referencia: " +fijo+"\n"
    resp
  end
  def send_notice_mail(user)
    UserMailer.notify_email(user).deliver_now!
  end
end
