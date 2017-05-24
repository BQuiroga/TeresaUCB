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
end
