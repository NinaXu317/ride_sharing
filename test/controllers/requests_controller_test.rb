require 'test_helper'

class RequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @request = requests(:one)
  end

  test "should get index" do
    get requests_url
    assert_response :success
  end

  test "should get new" do
    get new_request_url
    assert_response :success
  end

  test "should create request" do
    assert_difference('Request.count') do
      post requests_url, params: { request: { distance: @request.distance, end_city: @request.end_city, end_street_address: @request.end_street_address, end_zip: @request.end_zip, highest_price_to_pay: @request.highest_price_to_pay, matched_availability_id: @request.matched_availability_id, request_status: @request.request_status, start_city: @request.start_city, start_street_address: @request.start_street_address, start_zip: @request.start_zip, trip_date: @request.trip_date, trip_time: @request.trip_time, user_id: @request.user_id } }
    end

    assert_redirected_to request_url(Request.last)
  end

  test "should show request" do
    get request_url(@request)
    assert_response :success
  end

  test "should get edit" do
    get edit_request_url(@request)
    assert_response :success
  end

  test "should update request" do
    patch request_url(@request), params: { request: { distance: @request.distance, end_city: @request.end_city, end_street_address: @request.end_street_address, end_zip: @request.end_zip, highest_price_to_pay: @request.highest_price_to_pay, matched_availability_id: @request.matched_availability_id, request_status: @request.request_status, start_city: @request.start_city, start_street_address: @request.start_street_address, start_zip: @request.start_zip, trip_date: @request.trip_date, trip_time: @request.trip_time, user_id: @request.user_id } }
    assert_redirected_to request_url(@request)
  end

  test "should destroy request" do
    assert_difference('Request.count', -1) do
      delete request_url(@request)
    end

    assert_redirected_to requests_url
  end
end
