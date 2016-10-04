class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.create(user_params)

        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Account successfully created!"
            redirect_to blogs_url
        else
            render "new"
        end
    end

    def show
        @user = User.find(params[:id])
        @blogs = @user.blogs.page(params[:page]).per_page(5)
        @blog = Blog.new
    end

     def search
        keywords = params.require(:keywords)
        @users = User.where("lower(firstname) like ? OR lower(lastname) like ?", "%#{keywords.downcase}%", "%#{keywords.downcase}%").page(params[:page]).per_page(5)
    end

    private
    def user_params
        params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
    end
end
