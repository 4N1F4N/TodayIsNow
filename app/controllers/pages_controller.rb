class PagesController < ApplicationController
    def main
        
    end

    def main_pages
        @max_pages = Post.maximum("id").to_i / 10 + 1
        redirect_to main_path if params[:id].to_i == 0 || params[:id].to_i > @max_pages
    end

    def user_show
        
    end

    def post_show
        
    end

    def user_create

    end

    def user_login

    end
end
