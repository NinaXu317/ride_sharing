require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  fixtures :users, :requests, :makes, :vehicles, :notifications,:trips

  def setup
    @user = users(:one)
    @user2 = users(:two)
    # @request = requests(:one)
    @notification = notifications(:one)
    @trip = trips(:one)
    @vehicle = vehicles(:one)
  end
  
  test "should login in and go to search page" do
    get '/'
    assert_response :success
    get '/users/sign_in'
    assert_response :success
    @user.confirm
    sign_in @user
    post "/users/sign_in"
    assert_redirected_to root_path
    get search_user_requests_url(@user.id)
    assert_template 'requests/_searchform'
    assert_response :success

  end

  test "rider should login and go to make request" do
    get '/'
    assert_template 'static_pages/home'
    get new_user_registration_path
    # assert_response 200, status
    @user2.confirm
    sign_in @user2
    post "/users/sign_in"
    assert_redirected_to root_path
    get new_user_request_path(@user2.id)
    assert_response :success
    assert_template 'requests/new' 
  end

  test "rider should make a request and search request" do
    get '/'
    assert_template 'static_pages/home'
    get new_user_registration_path
    # assert_response 200, status
    @user2.confirm
    sign_in @user2
    post "/users/sign_in"
    assert_redirected_to root_path
    post user_requests_path(@user2.id)
    # assert_redirected_to user_request_path(@user2.id,:request_id)
    get search_user_requests_path(@user2.id)
    assert_template 'requests/search'
  end

  test "driver login to edit profile and see profile" do
    get '/'
    assert_template 'static_pages/home'
    get new_user_registration_path
    # assert_response 200, status
    @user.confirm
    sign_in @user
    post "/users/sign_in"
    assert_redirected_to root_path
    get edit_user_path(@user.id)
    assert_response :success
    assert_template 'users/edit'
    get user_path(@user.id)
    assert_response :success
    assert_template 'users/show'
     
  end

  test "rider login and go to profile to see past trip " do
    @user2.confirm
    sign_in @user2
    post "/users/sign_in"
    assert_redirected_to root_path
    get user_path(@user2.id)
    assert_template 'users/show'
    get all_trips_user_trips_path(@user2.id)
    assert_template 'trips/show_upcoming_trip'
    get trip_complete_user_trip_path(@user2.id, @trip.request_id)
    assert_response :success
    assert_template 'trips/trip_complete'
  end

  test "start a trip and pick up a rider " do
    @user.confirm
    sign_in @user
    post "/users/sign_in"
    assert_redirected_to root_path
    get pickup_user_trip_path(@user.id,@trip.availability_id)
    # assert_template 'trips/rider_pickup'
    get start_user_trips_path(@user.id)
    assert_template 'trips/start_trip'
  end

  test "user create a vehicle" do
    @user.confirm
    sign_in @user
    get new_user_vehicle_path(@user)
    assert_select 'input',6
    post user_vehicles_path(@user, vehicle:{license_number: @vehicle.license_number,
                                            vehicle_make: @vehicle.vehicle_make,
                                            vehicle_model: @vehicle.vehicle_model,
                                            vehicle_color: @vehicle.vehicle_color,
                                            vehicle_plate: @vehicle.vehicle_plate})
    
    follow_redirect!
    assert_select 'a',8
    get edit_user_vehicle_path(@user.id)
    assert_template 'vehicles/_form'

  end
  
  test "driver should search " do
    @user.confirm
    sign_in @user
    post user_trips_path(@user.id , trip:{driver_id: @trip.driver_id,
                                      rider_id: @trip.rider_id,
                                      availability_id: @trip.availability_id,
                                      request_id: @trip.request_id})
    assert_select 'a',2
    get pickup_user_trip_path(@user.id, @trip.id)
    assert_select 'a',2
  end

  test "driver make post and search request" do

  end


end
