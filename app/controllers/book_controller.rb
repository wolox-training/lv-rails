class BookController < ApplicationController
  include Wor::Paginate

  def index
    books = Book.filter(params.require(:book).permit(%i[genre title author]))
    render_paginated books, each_serializer: BookSerializer
  end

  def show
    book = Book.find(params[:id])
    render book
  end
end
