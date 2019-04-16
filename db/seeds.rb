# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Author.create( name: "Jules Verne" )
# author = Author.new(name: "Stephen King")
# author.save

# Author.create( name: "Sally Rooney" )


authors = [
    {
        name: "Stephen King"
    },
    {
        name: "William Shakespeare"
    },
    {
        name: "Fredrick Douglas"
    }
]

failed_saves = []
authors.each do |author|
  new_author = Author.new(author)
  if new_author.save
    puts "Saved #{author[:name]} Successfully"
  else
    failed_saves << author[:name]
  end
end

puts "Failed Saves #{failed_saves}"

books = [
    {
        title: "Romeo & Juliet",
        author_id: Author.find_by(
            name: "William Shakespeare").id,
        description: "Romantic Play",
        publication_date: 1603
    },
    {
        title: "My Bondage & My Freedom",
        author_id: Author.find_by(
            name: "Fredrick Douglas").id,
        description: "An Autobiography",
        publication_date: 1855
    }
]

books.each do |book|
    Book.create(book)
end