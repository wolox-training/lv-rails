class UserMailer < ApplicationMailer
  def new_rent_notification(rent)
    @rent = rent
    @user = User.find(rent.user_id)
    @book = Book.find(rent.book_id)

    mail to: 'lucas.voboril@wolox.com.ar',
         subject: 'New rent notification'
  end
end
