class BooksController < ApplicationController
  def index
    @books = []
  end

  def search
    @books = Book.search params

    render 'index'
  end
end
