class RentPolicy < ApplicationPolicy
  attr_reader :user, :rent

  def initialize(user, rent)
    @user = user
    @rent = rent
  end

  # User must only index yours rents
  def index?
    user.id.present?
  end
end
