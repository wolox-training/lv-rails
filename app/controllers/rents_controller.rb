class RentsController < ApplicationController
  include Wor::Paginate

  before_action :authenticate_user!, only: %i[create index]

  def create
    rent = current_user.rents.build(create_params)
    if rent.save
      send_mails(rent)
      render json: rent, status: :created
    else
      render json: { errors: rent.errors.messages }, status: :unprocessable_entity
    end
  end

  def index
    rents = index_collection
    authorize rents
    render_paginated rents, each_serializer: RentSerializer
  end

  private

  def index_collection
    rents = Rent.filter(param_index) if params['rent'].present?
    rents ||= Rent.all
    rents
  end

  def param_index
    params.require(:rent).permit(%i[user book from to])
  end

  def send_mails(rent)
    RentMailer.new_rent_notification(rent.id).deliver_later
    RentNotificationWorker.perform_in((rent.to - rent.from).days, rent.id)
  end

  def create_params
    params.require(:rent).permit(:from, :to, :book_id)
  end
end
