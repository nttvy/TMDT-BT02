class SessionsController < ApplicationController
  before_filter :authorize, only: [:destroy]
  before_filter :logined, only: [:new, :create, :crete_with_twitter]

  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in successfully!"
      redirect_to root_url
    else
      flash[:error] = "Email or password is invalid."
      redirect_to new_session_path
    end
  end

  def create_with_twitter
    if User.find_by_email(env["omniauth.auth"].uid + "@twitter.com")
      user = User.find_by_email(env["omniauth.auth"].uid + "@twitter.com")
    else
      user = User.from_omniauth(env["omniauth.auth"])
    end

    session[:user_id] = user.id
    flash[:success] = "Logged in successfully!"
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out successfully!"
    redirect_to root_url
  end
end
