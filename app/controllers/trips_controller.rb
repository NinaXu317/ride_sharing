class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @trips = Trip.all
    respond_with(@trips)
  end

  def pickup
    # find the request with the driver_id that has the closest timestamp
    @ride = Ride.find_by(driver: current_user)
    availability = Availability.find(@ride.availability_id)
    dest_lat = availability.end_lat
    dest_lon = availability.end_lon

    puts "successfully created"
    if request.xhr?
      # render data on ajax request
      curr_lat = params[:curr_lat]
      curr_lon = params[:curr_lon]
      respond_to do |format|
        format.js { render partial: 'rides/startRide', :locals => { :curr_lat => curr_lat, :curr_lon => curr_lon, :dest_lat => dest_lat, :dest_lon => dest_lon}}
      end
    end
  end

  def show
    @driver_id = current_user.id
    availability = Availability.upcoming.find_closest_availability(@driver_id)
    @availability_id = availability.id
    @rider_id = availability.matched_user_id
    @request_id = availability.matched_request_id
    if @request_id != -10
      ride_request = Request.find_by(id: @request_id)
    end
    rider = User.find(@rider_id)
    @ride = Ride.find_by(driver: current_user, rider:rider, availability_id: @availability_id)
    if @ride.nil?
      @ride = Ride.create!(driver: current_user, rider: rider, request_id: @request_id, availability_id: @availability_id)
    end
    # if there is no request, driver and rider start at the same address and end at the same address
    respond_to do |format|
      format.html
    end
  end

  def new
    @trip = Trip.new
    respond_with(@trip)
  end

  def edit
  end

  def create
    @trip = Trip.new(trip_params)
    flash[:notice] = 'Trip was successfully created.' if @trip.save
    respond_with(@trip)
  end

  def update
    flash[:notice] = 'Trip was successfully updated.' if @trip.update(trip_params)
    respond_with(@trip)
  end

  def destroy
    @trip.destroy
    respond_with(@trip)
  end

  private
    def set_trip
      @trip = Trip.find(params[:id])
    end

    def trip_params
      params.require(:trip).permit(:driver_id, :rider_id, :availability_id, :request_id, :status)
    end
end
