require "test_helper"

describe AuthorsController do
  before do
    Author.create(name: "test author")
  end
  
  describe "index" do 
    it "should get index" do
      get authors_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "should get show" do
      get author_path(Author.first.id)

      must_respond_with :success
    end

    it "will respond with 404 if the author is not found" do

      get author_path(-1)

      must_respond_with :not_found
    end
  end


  describe "destory" do
    it "should  destroy authors" do
      expect {
        delete author_path(Author.first.id)
      }.must_change "Author.count", -1

      must_respond_with :redirect
    end

    it "should respond with 404 if the author does not exist" do 
      expect {
        delete author_path(-1)
      }.wont_change "Author.count"

      must_respond_with :not_found
    end
  end

  describe "edit" do 
    it "should get edit" do
      get edit_author_path(Author.first.id)

      must_respond_with :success
    end

    it "should respond with 404 if the author doesn't exist" do
      get edit_author_path(-1)

      must_respond_with :not_found
    end
  end

  describe "update" do
    it "should update authors" do
      author_hash = {
        author: {
          name: "test 2"
        }
      }
      patch author_path(Author.first.id), params: author_hash

      must_respond_with :redirect
      expect(Author.find_by(name: "test 2")).wont_be_nil
    end

    it "should respond with a bad request if the name is empty" do
      author_hash = {
        author: {
          name: ""
        }
      }
      patch author_path(Author.first.id), params: author_hash

      must_respond_with :bad_request
      expect(Author.find_by(name: "test 2")).must_be_nil
    end

    it "should respond with not found if the author isn't found" do
      author_hash = {
        author: {
          name: "test 2"
        }
      }
      patch author_path(-1), params: author_hash

      must_respond_with :not_found
      expect(Author.find_by(name: "test 2")).must_be_nil
    end
  end

  describe "new" do 
    it "should get new" do
      get new_author_path

      must_respond_with :success
    end
  end

  describe "create" do 
    it "should create new authors" do
      author_hash = {
        author: {
          name: "test 3"
        }
      }
      expect {
        post authors_path, params: author_hash
      }.must_change "Author.count", 1

      must_respond_with :redirect
    end

    it "should respond with bad request if the author is missing a name" do
      author_hash = {
        author: {
          name: ""
        }
      }
      expect {
        post authors_path, params: author_hash
      }.wont_change "Author.count"

      must_respond_with :bad_request
    end
  end

end
