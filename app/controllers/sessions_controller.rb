class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, status: 301
    else
      # flash[:alert] = "Invalid email or password"
      redirect_to login_path, status: 301
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
