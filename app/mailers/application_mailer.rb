class ApplicationMailer < ActionMailer::Base
  default from: "teresanotificaciones@gmail.com"
  layout 'mailer'
  def notice_mail(user)
    recipients user.email
    from "Bolsa de Trabajo <teresanotificaciones@gmail.com>"
    subject "¡Deberias ver esto!"
    sent_on  Time.now
  end
end
