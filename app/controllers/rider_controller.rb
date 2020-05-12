class RiderController < ApplicationController
<<<<<<< HEAD
  before_action :authenticate_user!
=======
  include RiderHelper
>>>>>>> 989b9a35c71141d8d650adfe2fb1293b0c7b6139

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
    @trip = params[:trip_id]
  end

  def end_trip
    @trip = Trip.find(params[:trip_id])
    if params[:rating]
      driver = User.find(@trip.driver_id)
      rider = User.find(@trip.rider_id)
      if params[:rating]
        rating = params[:rating]
        rate_user(driver, rider, @trip, rating[:star].to_i)
        render 'finish'
      end
    end

  end
end
