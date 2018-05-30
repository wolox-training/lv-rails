class RentPolicy < ApplicationPolicy
  attr_reader :user, :rent

  def initialize(user, rent)
    @user = user
    @rent = rent
  end

  # Until now anyone can create a rent
  def create
    true
  end

  # User must only index yours rents
  def index
    true
  end
end
