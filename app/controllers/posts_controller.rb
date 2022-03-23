class PostsController < ApplicationController
    def create
        if session[:user_id]
            post = Post.new(heading: post_params[:heading], text: post_params[:text], user_id: session[:user_id])
            post.save
        end
        redirect_to '/'
    end
    
    private 
        def post_params
            params.require(:post).permit(:heading, :text)
        end
end
