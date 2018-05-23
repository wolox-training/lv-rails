class UserMailer < ApplicationMailer
  default domain: Rails.application.secrets.user_mail_domain,
          password: Rails.application.secrets.user_mail_password,
          user_name: Rails.application.secrets.user_mail_user_name,
          address: Rails.application.secrets.user_mail_address,
          port: Rails.application.secrets.user_mail_port,
          authentication: Rails.application.secrets.user_mail_authentication.to_sym

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
