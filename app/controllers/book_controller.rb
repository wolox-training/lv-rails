class BookController < ApplicationController
  include Wor::Paginate

  before_action :authenticate_user!, only: %i[show index]

  def index
    @books = Book.filter(params.require(:book).permit(%i[genre title author]))
    render_paginated @books, each_serializer: BookSerializer
  end

  def show
    @book = Book.filter(params.require(:book).permit(:id))
    render_paginated @book
  end
end
