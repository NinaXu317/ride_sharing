class SessionsController < ApplicationController
# class SessionsController < Devise::SessionsController
# end


# class SessionsController < ApplicationController
#   def new
#   end
#
#   def create
#     @user = User.find_by(email: params[:email])
#     if @user && @user.authenticate(params[:password])
#       session[:user_id] = @user.id
#       cookies.signed['user_id'] = @user.id
#       # cookies.signed['user_expires_at'] = 30.minutes.from_now
#       redirect_to root_path, status: 301
#     else
#       # flash[:alert] = "Invalid email or password"
#       redirect_to new_session_path
#     end
#   end
#
#   def destroy
#     session[:user_id] = nil
#     if !cookies.signed['user_id'].nil? && !cookies.signed['user.expires_at'].nil?
#       cookies.signed['user_id'] = @user.id
#       # cookies.signed['user_expires_at'] = 30.minutes.from_now
#     end
#     redirect_to root_path
#   end
#
end
