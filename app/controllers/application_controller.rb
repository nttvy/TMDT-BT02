class ApplicationController < ActionController::Base
   before_filter :get_tweets

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

   def get_tweets
       if current_user
           if current_user.provider == "twitter"
               @tweets = current_user.load_tweets
           end
       end
   end
end
