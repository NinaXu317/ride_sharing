class RiderController < ApplicationController

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

  end

  def end_trip
  end
end
