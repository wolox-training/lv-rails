class BookController < ApiController
  include Wor::Paginate

  def index
    books = if params['book'].present?
              Book.filter(params.require(:book).permit(%i[genre title author]))
            else
              Book.all
            end
    render_paginated books, each_serializer: BookSerializer
  end

  def show
    book = Book.find(params[:book][:id])
    render json: book, status: 200
  end
end
