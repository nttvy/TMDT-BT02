class CommentsController < ApplicationController
    before_action :find_blog
    before_filter :authorize, only: [:create]

    def create
        @comment = @blog.comments.create!(comment_params)
        
        redirect_to blog_path(@blog.id)
    end


    def find_blog
        @blog = Blog.find(params[:blog_id])
    end

    private 
    def comment_params
        params.require(:comment).permit(:content).merge!(user: current_user)
    end
end
