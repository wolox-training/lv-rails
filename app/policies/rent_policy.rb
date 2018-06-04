class RentPolicy < ApplicationPolicy
  attr_reader :user, :rent

  def initialize(user, rent)
    @user = user
    @rent = rent
  end

  def index?
    # the variable name is "rent" but it contains a collection
    rent.to_a.all? { |record| record.user_id == user.id }
  end

  def show?
    rent.user_id == user.id
  end
end
