module SessionsHelper
    def current_user
        if session[:user_id]
          @user = User.find(session[:user_id])
        end
    end

    def logged_in?
        !current_user.nil?
    end

    def authorized
        redirect_to login_path unless logged_in?
    end

end
