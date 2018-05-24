class RentsController < ApplicationController
  include Wor::Paginate

  before_action :authenticate_user!, only: %i[create index]

  def create
    rent = Rent.create(params[:rent])
    render json: rent, status: 201
  end

  def index
    rents = if params['rent'].present?
              Rent.filter(params.require(:rent).permit(%i[user book from to]))
            else
              Rent.all
            end
    render_paginated rents, each_serializer: RentSerializer
  end
end
