class PostsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
        if session[:user_id] && User.find_by(id:session[:user_id]).can_create_post?
            post = Post.new(heading: post_params[:heading], text: post_params[:text], user_id: session[:user_id], status: params[:status]) if session[:user_id]
            return redirect_to post if post.save
            flash[:alert] = post.errors.full_messages
            redirect_to post_create_path
        end
        redirect_to post_create_path
    end

    def edit
        if session[:user_id] && User.find_by(id:session[:user_id]).can_change_post?
            post = Post.find(post_edit_params[:id])
            return redirect_to post if post.update(heading:post_edit_params[:heading], text:post_edit_params[:text], status: params[:status])
            flash[:alert] = post.errors.full_messages
            return redirect_to post_edit_path
        end
        redirect_to main_path
    end

    def delete 
        if session[:user_id] && User.find_by(id:session[:user_id]).can_delete_post?
            post = Post.find(params[:id])
            post.delete
        end
        redirect_to main_path
    end
    
    private 
        def post_params
            params.require(:post).permit(:heading, :text)
        end

        def post_edit_params
            params.require(:post).permit(:heading, :text, :id)
        end
end
