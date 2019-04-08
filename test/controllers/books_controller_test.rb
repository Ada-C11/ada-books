require "test_helper"

describe BooksController do
  it "should get index" do
    # Action
    get "/books"
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
      valid_book_id = 1

      # Act
      get "/books/#{valid_book_id}"

      # Assert
      must_respond_with :success

    end

    it "should give a 404 instead of showing a non-existant, invalid book" do

      # Arrange
      invalid_book_id = 999

      # Act
      get "/books/#{invalid_book_id}"

      # Assert
      must_respond_with :not_found

    end

  end
end
