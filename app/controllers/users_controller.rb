class UsersController < ApplicationController
    def create
        if user_params[:login].blank? || user_params[:password].blank?
            flash[:alert] = ['Пустой логин и/или пароль']
            redirect_to user_create_path
        elsif user_params[:password] == user_params[:password_confirmation]
            user = User.new(login:user_params[:login], password:user_params[:password])
            if user.save
                session[:user_id] = user.id
                return redirect_to user 
            end
            flash[:alert] = user.errors.full_messages
            return redirect_to user_create_path
        else
            flash[:alert] = ["Подверждение пароля не совпадает с паролем"]
            redirect_to user_create_path
        end
    end
    
    def login
        user = User.find_by(login:user_params[:login])
        if user_params[:login].blank? || user_params[:password].blank?
            flash[:alert] = ['Пустой логин и/или пароль']
            redirect_to user_login_path
        elsif user
            if user.authenticate(user_params[:password])
                session[:user_id] = user.id
                return redirect_to user
            else
                flash[:alert] = ['Неправильный пароль']
                redirect_to user_login_path
            end
        else 
            flash[:alert] = ['Такого пользователя нет']
            redirect_to user_login_path
        end
    end
    
    def logout
        session.delete(:user_id)
        redirect_to main_path
    end

    def up_role
        user = User.find(change_role_params[:user_id])
        user_session = User.find(change_role_params[:user_session_id])
        user.update_attribute(:status, 'writer') if user_session.can_change_role?
        redirect_to user
    end

    def down_role
        user = User.find(change_role_params[:user_id])
        user_session = User.find(change_role_params[:user_session_id])  
        user.update_attribute(:status, 'reader') if user_session.can_change_role?
        redirect_to user
    end

    def delete
        user = User.find(params[:id])
        Post.where(user_id: user.id).delete_all
        session.delete(:user_id) if user.id == session[:user_id]
        user.delete
        redirect_to main_path
    end

    private 
        def user_params
            params.require(:user).permit(:login, :password, :password_confirmation)
        end

        def change_role_params
            params.permit(:user_id, :user_session_id)
        end
end
