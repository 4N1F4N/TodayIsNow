class UsersController < ApplicationController
    def create
        if user_params[:password] == user_params[:password_confirmation]
            user = User.new(login:user_params[:login], password:user_params[:password])
            return redirect_to user if user.save
        end
        flash[:error] = "Неверный логин и/или пароль"
        redirect_to '/user/create'
    end
    
    def login
        user = User.find_by(login:user_params[:login])
        #if user && user.authenticate(user_params[:password])
        if user
            session[:user_id] = user.id
            return redirect_to user
        end
        redirect_to '/'
    end
    
    def logout
        session.delete(:user_id)
        redirect_to '/'
    end

    def up_role
        user = User.find(change_role_params[:user_id])
        user_session = User.find(change_role_params[:user_session_id])
        user.update_attribute(:status, 'writer') if user_session.status == 'admin'
        redirect_to user
    end

    def down_role
        user = User.find(change_role_params[:user_id])
        user_session = User.find(change_role_params[:user_session_id])  
        user.update_attribute(:status, 'reader') if user_session.status == 'admin'
        redirect_to user
    end

    private 
        def user_params
            params.require(:user).permit(:login, :password, :password_confirmation)
        end

        def change_role_params
            params.permit(:user_id, :user_session_id)
        end
end
