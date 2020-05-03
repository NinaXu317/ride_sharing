class ApplicationController < ActionController::Base
  # include SessionHelper
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  respond_to :html, :js

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :is_driver])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :password, :avatar])
    end
  # helper_method :logged_in?, :current_user, :set_verify_cookie
  # # respond_to :html, :json, :js
  #
  # def current_user
  #   puts "current"
  #   if session[:user_id]
  #     @user = User.find(session[:user_id])
  #   end
  # end
  #
  # def logged_in?
  #
  #   puts "logged in"
  #   !current_user.nil?
  # end
  #
  # def authorized
  #   puts "authorized"
  #   redirect_to login_path unless logged_in?
  # end

  # def set_verify_cookie
  #   puts current_user.nil?
  #   return unless current_user
  #   puts "verifying cookie"
  #   puts current_user.id
  #   cookies.signed[:user_id] = current_user.id
  # end

end
