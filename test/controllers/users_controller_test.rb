require "test_helper"

describe UsersController do
  describe "login" do
    # I am going to reserve testing the different behaviors (between existing user or new user) for this set of tests, rather than in current
  end

  describe "current" do
    it "responds with success if a user is logged in" do

      # Arrange: We have to log in as a user by NOT manipulating session... we will do a login action!
      logged_in_user = perform_login

      # Act: We need to still make a request to get to the users controller current action
      get current_user_path

      # Assert: Check that it responds with success
      must_respond_with :success
    end

    it "responds with a redirect if no user is logged in" do
      get current_user_path
      must_respond_with :redirect
    end
  end
end
