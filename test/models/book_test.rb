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
  end
end

# Describe regression testing
