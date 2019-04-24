class BooksController < ApplicationController
  before_action :find_individual_book, only: [:show, :edit, :update, :destroy]

  def index
    if params[:author_id]
      @books = Book.where(author: Author.find_by(id: params[:author_id]))
    else
      @books = Book.all.order(:title)
    end
  end

  def show
    if @book.nil?
      flash[:error] = "Unknown book"

      redirect_to books_path
    end
  end

  def new
    @book = Book.new(title: "Default Title")

    if params[:author_id]
      @book.author = Author.find_by(id: params[:author_id])
    end
  end

  def create
    book = Book.new(book_params)

    is_successful = book.save

    if is_successful
      flash[:success] = "Book added successfully"
      redirect_to book_path(book.id)
    else
      book.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new, status: :bad_request
    end
  end

  def edit
  end

  def update
    is_successful = @book.update(book_params)

    if is_successful
      flash[:success] = "book updated successfully"
      redirect_to book_path(@book.id)
    else
      @book.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit, status: :bad_request
    end
  end

  def destroy
    if @book.nil?
      flash[:error] = "That book does not exist"
    else
      @book.destroy
      flash[:success] = "#{@book.title} deleted"
    end

    redirect_to books_path
  end

  private

  def find_individual_book
    @book = Book.find_by(id: params[:id])
  end

  def book_params
    return params.require(:book).permit(:title, :author_id, :description, genre_ids: [])
  end
end
