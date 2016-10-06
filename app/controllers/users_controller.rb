class UsersController < ApplicationController
    before_filter :logined, only: [:new, :create]

    def new
        unless current_user.nil?
            redirect_to root_url
            return
        end
        @user = User.new
    end

    def create
        unless current_user.nil?
            redirect_to root_url
            return
        end

        @user = User.create(user_params)

        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Account successfully created!"
            redirect_to root_url
        else
            render "new"
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        @user.update(params.require(:user).permit(:firstname, :lastname, :image))

        redirect_to user_path(params[:id])
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
