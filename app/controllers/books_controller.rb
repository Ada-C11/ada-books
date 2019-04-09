class BooksController < ApplicationController
  BOOKS = [
    {title: "Hidden Figures", author: "Margot Lee Shetterly"},
    {title: "Practical Object-Oriented Design in Ruby", author: "Sandi Metz"},
    {title: "Kindred", author: "Octavia E. Butler"},
  ]

  def index
    @books = BOOKS
  end

  def show
    book_id = params[:id].to_i
    @book = BOOKS[book_id]
    raise
    # if the book is non-existant, we will give back a not_found/404 status code
    # You can move this logic/change this logic in any way that makes sense! Just be sure to test! :)
    if @book.nil?
      head :not_found
    end
  end
end
