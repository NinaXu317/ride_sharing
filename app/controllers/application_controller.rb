require "application_responder"

class ApplicationController < ActionController::Base

  self.responder = ApplicationResponder
  respond_to :html, :js

  helper_method :logged_in?, :current_user
  # respond_to :html, :json, :js
  
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
