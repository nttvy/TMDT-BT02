class UsersController < ApplicationController
    before_filter :logined, only: [:new, :create]

    def new
        @user = User.new
    end

    def create
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
        flash[:success] = "User successfully updated!"
        redirect_to user_path(params[:id])
    end

    def show
        @user = User.find(params[:id])
        @blogs = @user.blogs.page(params[:page]).per_page(5)
        @blog = Blog.new

        if current_user
            if current_user.friends.include?(@user)
                @friendship = current_user.friendships.find_by friend: @user
            end

            if current_user.inverse_friends.include?(@user)
                @friendship = current_user.inverse_friendships.find_by user: @user
            end

            if current_user.followings.include?(@user)
                @followship = current_user.followships.find_by following: @user
            end
        end
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
