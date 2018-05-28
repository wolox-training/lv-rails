class RentNotificationWorker
  include Sidekiq::Worker

  def perform(rent_id)
    RentMailer.rent_expiration_mail_notification(rent_id).deliver
  end
end
