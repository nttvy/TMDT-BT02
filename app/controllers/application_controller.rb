class ApplicationController < ActionController::Base
   protect_from_forgery with: :exception
   private
   def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
   end

   helper_method :current_user

   def authorize
    if current_user.nil?
        flash[:error] = "Not authorized"
        redirect_to login_url
    end
   end

   def logined
    redirect_to root_url unless current_user.nil?
   end
end
