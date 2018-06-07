class RentController < ApplicationController
  include Wor::Paginate

  before_action :authenticate_user!, only: %i[create index]

  def create
    @rent = Rent.create(params[:tweet])
  end

  def index
    @rents = Rent.filter(params.require(:rent).permit(%i[user book from to]))
    render_paginated @rents, each_serializer: RentSerializer
  end
end
