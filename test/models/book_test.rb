# test/models/book_test.rb

require "test_helper"

describe Book do
  let (:author) { Author.create(name: "test author") }
  let (:book) {
    Book.new title: "some title", author_id: author.id
  }

  it "must be valid" do
    valid_book = book.valid?
    # valid_book = book.save
    expect(valid_book).must_equal true
    # expect(book.valid?).must_equal true
  end

  describe "validations" do
    it "requires a title" do
      # Arrange
      book.title = nil

      # Act
      valid_book = book.valid?

      # Assert
      expect(valid_book).must_equal false
      expect(book.errors.messages).must_include :title
      expect(book.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "requires a unique title" do
      # Arrange
      Book.create(title: book.title, author_id: Author.first.id)

      # Act-Assert
      expect(book.save).must_equal false

      # Assert
      expect(book.errors.messages).must_include :title
      expect(book.errors.messages[:title]).must_equal ["has already been taken"]
    end
  end

  describe "relationships" do
    it "belongs to an author" do
      # Arrange
      author = Author.create(name: "new author")

      # Act
      book.author = author

      # Assert
      expect(book.author_id).must_equal author.id
    end

    it "can set the author through the author_id" do
      # Arrange
      new_author = Author.create(name: "new author")

      # Act
      book.author_id = new_author.id

      # Assert
      expect(book.author).must_equal new_author
    end

    it "can have 0 genres" do

      # Act
      genres = book.genres

      # Assert
      expect(genres.length).must_equal 0
    end

    it "can have 1 or more genres by shoveling a genre into book.genres" do
      # Arrange
      new_genre = Genre.new name: "Fantasy"

      # Act
      book.genres << new_genre

      # Assert
      expect(new_genre.books).must_include book
    end
  end

  describe "custom methods" do
  end
end

# Describe regression testing
