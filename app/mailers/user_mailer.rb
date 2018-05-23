class UserMailer < ApplicationMailer
  default domain: Rails.application.secrets.user_mail_domain,
          password: Rails.application.secrets.user_mail_password,
          user_name: Rails.application.secrets.user_mail_user_name,
          address: Rails.application.secrets.user_mail_address,
          port: Rails.application.secrets.user_mail_port,
          authentication: Rails.application.secrets.user_mail_authentication.to_sym

  def new_record_notification(record)
    # The email data should be:

    # Actual date of rent creation
    # Book detail
    # Date from and date to of the rent
    # El email debe estar maquetado

    @record = record
    mail to: "recipient@MYDOMAIN.com", 
         subject: "Success! You did it."
  end
end
