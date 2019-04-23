class Genre < ApplicationRecord
  has_and_belongs_to_many :books

  validates :name, presence: true

  def earliest_book
    genre_books = self.books.order(:publication_date)
    return genre_books.first.publication_date
  end
end
