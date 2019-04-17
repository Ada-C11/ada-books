class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end

  def show
    @author = Author.find_by(id: params[:id])

    if !@author
      head :not_found
    end
  end

  def destroy
    author = Author.find_by(id: params[:id])

    if !author
      head :not_found
    else
      author.books.each do |book|
        book.destroy
      end

      author.destroy
      redirect_to authors_path
    end
  end

  def edit
    @author = Author.find_by(id: params[:id])

    if !@author 
      head :not_found
    end
  end

  def update
    @author = Author.find_by(id: params[:id])
    if !@author
      head :not_found
    else
      if @author.update(author_params)
        redirect_to author_path(@author.id)
      else
        render :edit, status: :bad_request
      end
    end
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      redirect_to authors_path
    else
      render :new, status: :bad_request
    end
  end
  private

  def author_params
    return params.require(:author).permit(:name)
  end

end
