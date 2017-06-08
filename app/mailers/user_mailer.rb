class UserMailer < ApplicationMailer
  default from: 'notifications@bolsadetrabajo.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: '¡Bienvenido a la Bolsa de Trabajo!')
  end
  def notify_email(user)
    @user =  user
    @url = 'http://example.com/login'
    mail(to: @user.email, subject: "¡Deberias ver esto!")
  end
  def apply_job(notification)

    @user =User.find(notification.user_id)
    @sender =User.find(notification.sender)
    @description=notification.description
    @resume=@sender.resume
    @merits=@resume.merits
    @personal_info=@sender.personal_information
    @educations=@resume.educations
    @experiences=@resume.experiences
    @courses = @resume.courses
    @knowledges = @resume.knowledges
    @publications=@resume.publications
    @memberships=@resume.memberships
    @languages=@resume.languages
    @referentials=@resume.referentials
    @post=Post.find(notification.post_id)
    mail(to: @user.email, subject: "Alguien ha respondido a tu publicacion")
  end
end
