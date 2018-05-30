class BooksController < ApiController
  include Wor::Paginate

  before_action :authenticate_user!, only: %i[show index]

  def index
    books = if params['book'].present?
              Book.filter(params.require(:book).permit(%i[genre title author]))
            else
              Book.all
            end
    render_paginated books, each_serializer: BookSerializer
  end

  def show
    book = Book.find(params[:id])
    render json: book, status: 200
  end
end
