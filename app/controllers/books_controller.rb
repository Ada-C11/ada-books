class BooksController < ApplicationController
  BOOKS = [
    { title: "Hidden Figures", author: "Margot Lee Shetterly" },
    { title: "Practical Object-Oriented Design in Ruby", author: "Sandi Metz" },
    { title: "Kindred", author: "Octavia E. Butler" },
  ]

  def index
    # If there exists a route param value called "author_id"...
    # Then we can reasonably believe that we need to limit all books by author_id
    if params[:author_id]
      @books = Book.where(author: Author.find_by(id: params[:author_id]))
    else
      # If there isn't, then we can reasonably believe that all books should be ALL BOOKS!

      @books = Book.all.order(:title)
    end
  end

  def show
    book_id = params[:id]
    @book = Book.find_by(id: book_id)
    # if the book is non-existant, we will give back a not_found/404 status code
    # You can move this logic/change this logic in any way that makes sense! Just be sure to test! :)
    if @book.nil?
      flash[:error] = "Unknown book"

      redirect_to books_path
    end
  end

  def new
    # If there exists a route param value called "author_id"...
    # Then we can reasonably believe that we need to have that author already selected in the "new book" form

    @book = Book.new(title: "Default Title")

    if params[:author_id]
      @book.author = Author.find_by(id: params[:author_id])
    end
  end

  def create
    @book = Book.new(book_params)

    # If the book saves correctly, then we want to redirect to the show page of that book
    # Otherwise, we should give back something about the error (for now, 404)

    is_successful = @book.save

    if is_successful
      flash[:success] = "Book added successfully"
      redirect_to book_path(@book.id)
    else
      # flash.now[:failure] = "Didn't work"
      @book.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new, status: :bad_request
    end
  end

  def edit
    @book = Book.find_by(id: params[:id])
  end

  def update
    book = Book.find_by(id: params[:id])

    is_successful = book.update(book_params)

    if is_successful
      flash[:success] = "book updated successfully"
      redirect_to book_path(book.id)
    else
      @book = book
      @book.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit, status: :bad_request
    end
  end

  def destroy
    book = Book.find_by(id: params[:id])

    if book.nil?
      flash[:error] = "That book does not exist"
      redirect_to books_path
    else
      book.destroy
      flash[:success] = "#{book.title} deleted"
      redirect_to books_path
    end
  end

  private

  def book_params
    # Responsible for returning strong params as Rails wants it
    # Tells Rails that we want params to look like this nested hash, and only this nested hash
    # {
    #   book: {
    #     author: "some author",
    #     title: "some title",
    #     description: "description"
    #   }
    # }
    return params.require(:book).permit(:title, :author_id, :description)
  end
end
