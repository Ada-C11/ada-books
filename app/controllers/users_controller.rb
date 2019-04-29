class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]

    user = User.find_by(username: username)
    if user.nil?
      flash_msg = "Welcome new user"
    else
      flash_msg = "Welcome back #{username}"
    end

    user ||= User.create(username: username)

    session[:user_id] = user.id
    flash[:success] = flash_msg
    redirect_to root_path
  end

  def create
    auth_hash = request.env["omniauth.auth"]

    user = User.find_by uid: auth_hash[:uid], provider: "github"

    if user.nil?
      user = User.build_from_github(auth_hash)
    end

    if user.save
      flash[:success] = "Logged in as #{user.username}"
    else
      flash[:error] = "Could not log in with account #{user.errors.messages}"
      return redirect_to root_path
    end

    session[:user_id] = user.id

    redirect_to root_path
  end

  def current
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "You must be logged in first!"
      redirect_to root_path
    end
  end

  def logout
    user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    flash[:notice] = "Logged out #{user.username}"
    redirect_to root_path
  end
end
