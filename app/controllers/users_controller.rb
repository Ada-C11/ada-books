class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.create(username: username)

    if user.id
      session[:user_id] = user.id
      flash[:alert] = "#{user.username} logged in"
      redirect_to root_path
    else
      flash[:error] = "Unable to log in"
      redirect_to root_path
    end
  end

  def current
    @user = User.find_by(id: session[:user_id])
  end

  def logout
    session[:user_id] = nil
  end
end
