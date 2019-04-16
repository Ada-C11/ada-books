require "test_helper"

describe BooksController do
  it "should get index" do
    # Action
    get books_path
    # Same:
    # get books_path
    # get books_url

    # Assert
    must_respond_with :success
    #expect(response).must_be :success?
  end

  describe "show" do

    it "should be OK to show an existing, valid book" do

      # Arrange
      book = Book.create(title: "test book")
      valid_book_id = book.id

      # Act
      get book_path(valid_book_id)

      # Assert
      must_respond_with :success

    end

    it "should give a 404 instead of showing a non-existant, invalid book" do

      # Arrange
      invalid_book_id = 999

      # Act
      get book_path(invalid_book_id)

      # Assert
      must_respond_with :not_found

    end

  end

  describe "create" do
    it "will save a new book and redirect if given valid inputs" do

      # Arrange
      input_title = "Practical Object Oriented Programming in Ruby"
      input_author = "Sandi Metz"
      input_description = "A look at how to design object-oriented systems"
      test_input = {
        "book": {
          title: input_title,
          author_id: Author.create(name: input_author).id,
          description: input_description
        }
      }

      # Act
      expect {
        post books_path, params: test_input
      }.must_change 'Book.count', 1

      # Assert
      new_book = Book.find_by(title: input_title)
      expect(new_book).wont_be_nil
      expect(new_book.title).must_equal input_title
      expect(new_book.author.name).must_equal input_author
      expect(new_book.description).must_equal input_description

      must_respond_with :redirect

    end

    it "will return a 400 with an invalid book" do

      # Arrange
      input_title = "" # Invalid Title
      input_author = "Sandi Metz"
      input_description = "A look at how to design object-oriented systems"
      test_input = {
        "book": {
          title: input_title,
          author_id: Author.create(name: input_author).id,
          description: input_description
        }
      }

      # Act
      expect {
        post books_path, params: test_input
    }.wont_change "Book.count"
    # .must_change "Book.count", 0

      # Assert
      must_respond_with :bad_request

    end
  end

  describe "update" do
    # nominal: it should update a book and redirect to the book show page

    # edge case: it should render a 404 if the book was not found
  end

  describe "destroy" do
    it "returns a 404 if the book is not found" do
      invalid_id = "NOT A VALID ID"

      # Act
      # Try to do the Books#destroy action

      # Assert
      # Should respond with not found
      # The count will change by 0, i.e. won't change


    end

    it "can delete a book" do
      # Arrange - Create a book
      new_book = Book.create(title: "The Martian")

      expect {
        
        # Act
        delete book_path(new_book.id)

        # Assert
      }.must_change "Book.count", -1

      must_respond_with :redirect
      must_redirect_to books_path
    end


  end
end
