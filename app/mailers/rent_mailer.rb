class RentMailer < ApplicationMailer
  def new_rent_notification(rent_id)
    @rent = Rent.find(rent_id)
    mail to: 'lucas.voboril@wolox.com.ar',
         subject: 'New rent notification'
  end

  def rent_expiration_mail_notification(rent_id)
    @rent = Rent.find(rent_id)
    mail to: 'lucas.voboril@wolox.com.ar',
         subject: 'Rent expiration notificarion'
  end
end
