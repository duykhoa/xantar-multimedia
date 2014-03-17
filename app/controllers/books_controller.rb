class BooksController < ApplicationController
  def index
    @books = []
  end

  def search
    @books, @total = Book.search params

    render 'index'
  end
end
