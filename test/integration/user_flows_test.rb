require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  fixtures :users, :requests, :makes, :vehicles, :notifications

  def setup
    @user = users(:one)
    @user2 = users(:two)
    # @request = requests(:one)
    @notification = notifications(:one)
  end
  #
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
    assert_template 'static_pages/home'
    # assert_response :success

    get new_user_registration_path
    # assert_response 200, status
    @user.confirm
    sign_in @user
    post "/users/sign_in"
    assert_redirected_to root_path
    get search_user_requests_url(@user.id)
    # assert_equal 200, status
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
    assert_template 'users/edit'
    get user_path(@user.id)
    assert_template 'users/show'
     
  end

  test "rider login and go to profile to see past trip " do
    @user2.confirm
    sign_in @user2
    post "/users/sign_in"
    assert_redirected_to root_path
    get user_path(@user2.id)
    assert_template 'users/show'
    get trips_user_trips_path(@user.id)
    assert_template 'trips/show_upcoming_trip'
    get trip_complete_user_trips_path(@user.id)
    assert_template 'trips/trip_complete'
  end

  test "start a trip and pick up a rider " do
    @user.confirm
    sign_in @user
    post "/users/sign_in"
    assert_redirected_to root_path
    get rider_pickup_user_trips_path(@user.id)
    assert_template 'trips/rider_pickup'
    get start_user_trips_path(@user.id)
    assert_template 'trips/start_trip'
  end

  test "user create a vehicle" do
    @user.confirm
    sign_in @user
    get new_user_vehicle_path(@user)
    assert_template 'vehicles/_form'
    post user_vehicles_path(@user.id)
    follow_redirect!
    assert_template 'layouts/application'

  end
end
