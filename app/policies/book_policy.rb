class BookPolicy < ApplicationPolicy
  attr_reader :user, :rent

  def initialize(user, rent)
    @user = user
    @rent = rent
  end

  # An user must only index yours books
  def index
    true
  end

  # An user must only show any of yours books
  def show
    true
  end
end
