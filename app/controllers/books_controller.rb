class BooksController < ApplicationController
  BOOKS = [
    {title: "Hidden Figures", author: "Margot Lee Shetterly"},
    {title: "Practical Object-Oriented Design in Ruby", author: "Sandi Metz"},
    {title: "Kindred", author: "Octavia E. Butler"},
  ]

  def index
    @books = Book.all.order(:title)
  end

  def show
    book_id = params[:id]
    @book = Book.find_by(id: book_id)
    # if the book is non-existant, we will give back a not_found/404 status code
    # You can move this logic/change this logic in any way that makes sense! Just be sure to test! :)
    if @book.nil?
      head :not_found
    end
  end

  def new
    @book = Book.new(title: "Default Title")
  end

  def create
    book = Book.new(
      title: params["book"]["title"],
      author: params["book"]["author"],
      description: params["book"]["description"]
      )


    # If the book saves correctly, then we want to redirect to the show page of that book
    # Otherwise, we should give back something about the error (for now, 404)

    is_successful = book.save

    if is_successful
      redirect_to book_path(book.id)
    else
      # For Rails Week 1, not a requirement (not possible right now?) to test this case in controller tests
      head :not_found
    end
  end

  def destroy
    book = Book.find_by(id:  params[:id] )

    if book.nil?
      head :not_found
    else
      book.destroy
      redirect_to books_path
    end


  end
end
