class NewRentNotification < ApplicationJob
  queue_as :default

  def perform(rent)
    # @rent = rent
    # @user = User.find(rent.user_id)
    # @book = Book.find(rent.book_id)
  end
end
