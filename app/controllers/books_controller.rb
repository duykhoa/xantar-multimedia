class BooksController < ApplicationController
  def index
  end

  def search
    @results = Book.search params

    render 'index'
  end
end
