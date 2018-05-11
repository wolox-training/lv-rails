class BookController < ApplicationController
  include Wor::Paginate

  def index
    render_paginated Book
    @books = Book.filter(params.slice(:genre, :title, :author, :description))
  end

  def show
    @book = Book.filter(params.slice(id))
  end
end
