class BookController < ApplicationController
  def index
    @books = Book.filter(params.slice(:genre, :title, :author, :description))
  end

  def show
    @book = Book.filter(params.slice(id))
  end
end
