class Comentario < ActionMailer::Base
  default from: "comentarios@131voces.org",
          reply_to: 'voces@citivox.com'

  def send_email(nombre, comentario)
    to_emails = ['info@citivox.com','jparbros@gmail.com']
    to_emails << comentario.commentable.email if comentario.commentable and comentario.commentable.email
    @data_email = {nombre: nombre, comentario: comentario}
    mail(:to => to_emails, :subject => "Has recibido un comentario de #{nombre}")
  end
end
