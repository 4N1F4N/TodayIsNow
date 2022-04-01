class PagesController < ApplicationController
    def main
        
    end

    def all_posts
        @posts = Post.all
    end

    def user_show
        
    end

    def post_show
        
    end

    def post_closes
        @posts = Post.where(status: "close")
    end

    def user_create

    end

    def user_login

    end
end
