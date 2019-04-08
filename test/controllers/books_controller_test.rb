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
end
