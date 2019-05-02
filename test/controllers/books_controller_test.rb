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
      # book = Book.create(title: "test book", author_id: Author.create(name: "test").id)
      valid_book_id = books(:oop_part_two).id

      # Act
      get book_path(valid_book_id)

      # Assert
      must_respond_with :success
    end

    it "should give a flash notice instead of showing a non-existant, invalid book" do

      # Arrange
      book = books(:oop_part_two)
      invalid_book_id = book.id
      book.destroy

      # Act
      get book_path(invalid_book_id)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Unknown book"
    end
  end

  describe "create" do
    describe "Logged in users" do
      before do
        perform_login(users(:dee))
      end

      it "will save a new book and redirect if given valid inputs" do

        # Arrange
        input_title = "Practical Object Oriented Programming in Ruby"
        input_author = "Sandi Metz"
        input_description = "A look at how to design object-oriented systems"
        test_input = {
          "book": {
            title: input_title,
            author_id: Author.create(name: input_author).id,
            description: input_description,
          },
        }

        # Act
        expect {
          post books_path, params: test_input
        }.must_change "Book.count", 1

        # Assert
        new_book = Book.find_by(title: input_title)
        expect(new_book).wont_be_nil
        expect(new_book.title).must_equal input_title
        expect(new_book.author.name).must_equal input_author
        expect(new_book.description).must_equal input_description

        must_respond_with :redirect
      end
      it "will give a 400 error with invalid params" do

        # Arrange
        input_title = "" # invalid title
        input_author = "Sandi Metz"
        input_description = "A look at how to design object-oriented systems"
        test_input = {
          "book": {
            title: input_title,
            author_id: Author.create(name: input_author).id,
            description: input_description,
          },
        }

        # Act
        expect {
          post books_path, params: test_input
        }.wont_change "Book.count"

        # Assert
        expect(flash[:title]).must_equal ["can't be blank"]
        must_respond_with :bad_request
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
            description: input_description,
          },
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

    describe "Not Logged in users (Guest Users)" do
      it "will redirect to some page if the user attempts to do this with any input" do
        # Arrange
        input_title = "Practical Object Oriented Programming in Ruby"
        input_author = "Sandi Metz"
        input_description = "A look at how to design object-oriented systems"
        test_input = {
          "book": {
            title: input_title,
            author_id: Author.create(name: input_author).id,
            description: input_description,
          },
        }

        # Act
        expect {
          post books_path, params: test_input
        }.wont_change "Book.count"

        # Assert
        new_book = Book.find_by(title: input_title)
        expect(new_book).must_equal nil

        must_respond_with :redirect
        must_redirect_to root_path
      end
    end
  end

  describe "update" do
    # nominal: it should update a book and redirect to the book show page
    it "will update an existing book" do
      # Arrange
      starter_input = {
        title: "Becoming",
        author_id: Author.create(name: "Michelle Obama").id,
        description: "A book by the 1st lady",
      }

      book_to_update = Book.create(starter_input)

      input_title = "101 Bottles of OOP" # Valid Title
      input_author = "Sandi Metz"
      input_description = "A look at how to design object-oriented systems"
      test_input = {
        "book": {
          title: input_title,
          author_id: Author.create(name: input_author).id,
          description: input_description,
        },
      }

      # Act
      expect {
        patch book_path(book_to_update.id), params: test_input
      }.wont_change "Book.count"
      # .must_change "Book.count", 0

      # Assert
      must_respond_with :redirect
      book_to_update.reload
      expect(book_to_update.title).must_equal test_input[:book][:title]
      expect(book_to_update.author.name).must_equal Author.find(test_input[:book][:author_id]).name
      expect(book_to_update.description).must_equal test_input[:book][:description]
    end

    it "will return a bad_request (400) when asked to update with invalid data" do

      # Arrange
      starter_input = {
        title: "Becoming",
        author_id: Author.create(name: "Michelle Obama").id,
        description: "A book by the 1st lady",
      }

      book_to_update = Book.create(starter_input)

      input_title = "" # Invalid Title
      input_author = "Sandi Metz"
      input_description = "A look at how to design object-oriented systems"
      test_input = {
        "book": {
          title: input_title,
          author_id: Author.create(name: input_author).id,
          description: input_description,
        },
      }

      # Act
      expect {
        patch book_path(book_to_update.id), params: test_input
      }.wont_change "Book.count"
      # .must_change "Book.count", 0

      # Assert
      must_respond_with :bad_request
      book_to_update.reload
      expect(book_to_update.title).must_equal starter_input[:title]
      expect(book_to_update.author.name).must_equal Author.find(starter_input[:author_id]).name
      expect(book_to_update.description).must_equal starter_input[:description]
    end

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
      new_book = Book.create(title: "The Martian", author_id: Author.create(name: "Someone").id)

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
