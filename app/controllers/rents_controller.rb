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
    rents = if params['rent'].present?
              Rent.filter(params.require(:rent).permit(%i[user book from to]))
            else
              Rent.all
            end
    render_paginated rents, each_serializer: RentSerializer
  end

  private

  def send_mails(rent)
    RentMailer.new_rent_notification(rent.id).deliver_later
    RentNotificationWorker.perform_in((rent.to - rent.from).days, rent.id)
  end

  def create_params
    params.require(:rent).permit(:from, :to, :book_id)
  end
end
