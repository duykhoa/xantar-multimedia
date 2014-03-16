class BooksController < ApplicationController
  def index
  end

  def search
    @books = Book.search params

    render 'index'
  end
end
