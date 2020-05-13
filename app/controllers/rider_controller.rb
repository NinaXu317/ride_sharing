class RiderController < ApplicationController
  before_action :authenticate_user!
  include RiderHelper

  def start_trip
    trip_id = params[:trip_id]
    @trip = Trip.find(trip_id)
    puts @trip.driver_id
    @driver = User.find(@trip.driver_id)
    puts @driver.id
    @vehicle = Vehicle.find_by(user_id: @driver.id)
    if @trip.request_id != -1
      @request = Request.find(@trip.request_id)
    else
      @availability = Availability.find(@trip.availability_id)
    end
  end

  def during_trip
    @trip = Trip.find(params[:trip_id])
  end

  def end_trip
    if params[:rating]
      rating = params[:rating]
      trip_id = rating[:trip_id]
      @trip = Trip.find(trip_id)
      driver = User.find(@trip.driver_id)
      rider = User.find(@trip.rider_id)
      rate_user(driver, rider, @trip, rating[:star].to_i)
      render 'finish'
    else
      @trip = Trip.find(params[:trip_id])
    end
  end

  private
  def rating_params
    params.require(:rating).permit(:star, :trip_id)
  end
end