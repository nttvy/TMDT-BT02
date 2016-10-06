class SessionsController < ApplicationController
  before_filter :authorize, only: [:destroy]
  before_filter :logined, only: [:new, :create, :crete_with_twitter]

  def new
    unless current_user.nil?
      redirect_to root_url
      return
    end
  end

  def create
    unless current_user.nil?
      redirect_to root_url
      return
    end

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
    unless current_user.nil?
      redirect_to root_url
      return
    end

    user = User.from_omniauth(env["omniauth.auth"])

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
