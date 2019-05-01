require "test_helper"

describe UsersController do
  describe "login" do
    # I am going to reserve testing the different behaviors (between existing user or new user) for this set of tests, rather than in current

    it "can log in an existing user" do
      # Arrange
      user_count = User.count

      # Act
      user = perform_login

      expect(user_count).must_equal User.count

      # Should also test Flash notices

      expect(session[:user_id]).must_equal user.id
    end

    it "can log in a new user" do
      # Arrange
      user = User.new(provider: "github", username: "bob", uid: 987, email: "bob@hope.com")

      expect {
        # Act
        perform_login(user)
        # Assert
      }.must_change "User.count", 1

      # Should also test Flash notices
      user = User.find_by(uid: user.uid, provider: user.provider)

      expect(session[:user_id]).must_equal user.id
    end

    it "will redirect back to root with a flash message if not coming from github" do
      # Skip Auth hash creation
    end
  end

  describe "current" do
    it "responds with success if a user is logged in" do
      skip # will update when we do OAuth testing

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
