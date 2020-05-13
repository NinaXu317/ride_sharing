class TripsController < ApplicationController
  include TripsHelper
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  respond_to :html

  def index
    @trips = Trip.all
    respond_with(@trips)
  end

  def cancel
    @trip = Trip.find(params[:trip_id])
    availability_id = @trip.availability_id
    request_id = @trip.request_id
    if request_id != -1
      request = Request.find(request_id)
      request.request_status = "canceled"
      request.save
    end
    if availability_id != -1
      availability = Availability.find(availability_id)
      availability.availability_status = "canceled"
      availability.save
    end
    redirect_to notify_cancel_user_notifications_path(current_user.id, :trip_id => @trip.id) and return
  end

  def cancel_request
    puts "canceling"
    id = params[:id]
    puts params[:type]
    if params[:type] == "request"
      r = Request.find(id)
      puts r.id
      r.request_status = "canceled"
      r.save
    end
    if params[:type] == "availability"
      a = Availability.find(id)
      a.availability_status = "canceled"
      a.save
    end
  end

  def show_upcoming_trip
    # show driver's upcoming trips
    upcoming_trips = []
    past_trips = []
    if current_user.is_driver
      u_trips = Trip.upcoming.find_by_driver(current_user.id)
      p_trips = Trip.completed.find_by_driver(current_user.id)
      @upcoming_trips = find_trip(u_trips, upcoming_trips)
      @past_trips = find_trip(p_trips, past_trips)
      @submitted_availabilities = Availability.started.find_availability_by_user_id(current_user.id)
      @waiting_availabilities = Availability.waiting.find_availability_by_user_id(current_user.id)
    # show rider's upcoming trips
    else
      u_trips = Trip.upcoming.find_by_rider(current_user.id)
      p_trips = Trip.completed.find_by_rider(current_user.id)
      @upcoming_trips = find_trip(u_trips, upcoming_trips)
      @past_trips = find_trip(p_trips, past_trips)
      @submitted_requests = Request.started.find_request_by_user_id(current_user.id)
      @waiting_requests = Request.waiting.find_request_by_user_id(current_user.id)
    end
  end

  def pickup
    # find the request with the driver_id that has the closest timestamp
    @trip = Trip.find(params[:id])
    if @trip.availability_id != -1
      availability = Availability.find(@trip.availability_id)
      dest_lat = availability.end_lat
      dest_lon = availability.end_lon
    else
      request_t = Request.find(@trip.request_id)
      dest_lat = request_t.end_lat
      dest_lon = request_t.end_lon
    end

    if request.xhr?
      # render data on ajax request
      curr_lat = params[:curr_lat]
      curr_lon = params[:curr_lon]
      respond_to do |format|
        format.js { render partial: 'startRide', :locals => { :curr_lat => curr_lat, :curr_lon => curr_lon, :dest_lat => dest_lat, :dest_lon => dest_lon}}
      end
    end
  end

  def trip_complete
    @trip = Trip.find(params[:id])
    driver = User.find(@trip.driver_id)
    rider = User.find(@trip.rider_id)
    if params[:rating]
      rating = params[:rating]
      rate_user(driver, rider, @trip, rating[:star].to_i)
      render 'finish'
    end
  end

  def show
    @trip = Trip.find(params[:id].to_i)
    @driver_id = current_user.id
    # @trip = Trip.id
    @availability_id = @trip.availability_id
    @rider_id = @trip.rider_id
    @rider = User.find(@rider_id)
    @request_id = @trip.request_id
    if @request_id != -1
      @request = Request.find_by(id: @request_id)
    else
      @availability = Availability.find(@availability_id)
    end
    # if there is no request, driver and rider start at the same address and end at the same address
    if request.xhr?
      # render data on ajax request
      dest_lat = @request.end_lat
      dest_lon = @request.end_lon
      curr_lat = params[:curr_lat]
      curr_lon = params[:curr_lon]
      respond_to do |format|
        format.js { render partial: 'rider_pickup', :locals => { :curr_lat => curr_lat, :curr_lon => curr_lon, :dest_lat => dest_lat, :dest_lon => dest_lon}}
      end
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

    def rating_params
      params.require(:rating).permit(:star)
    end

    def trip_params
      params.require(:trip).permit(:driver_id, :rider_id, :availability_id, :request_id, :status)
    end
end
