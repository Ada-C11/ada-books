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
          author: input_author,
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
      expect(new_book.author).must_equal input_author
      expect(new_book.description).must_equal input_description

      must_respond_with :redirect

    end
  end
end
