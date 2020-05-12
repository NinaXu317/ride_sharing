require 'test_helper'

class RiderControllerTest < ActionDispatch::IntegrationTest
  test "should get start_trip" do
    get rider_start_trip_url
    assert_response :success
  end

  test "should get end_trip" do
    get rider_end_trip_url
    assert_response :success
  end

end
