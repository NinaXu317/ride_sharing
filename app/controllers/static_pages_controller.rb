class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def help
  end

  def pickup
    @users = User.all
    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
    end
  end
end
