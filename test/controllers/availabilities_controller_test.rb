require 'test_helper'

class AvailabilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # @availability = availabilities(:one)
    # @user = User.create(:one)
  end

  # test "should get index" do
  #   get user_availabilities_url(@user.id)
  #   assert_response :success
  # end

#   test "should get new" do
#     get new_availability_url
#     assert_response :success
#   end

#   test "should create availability" do
#     assert_difference('Availability.count') do
#       post availabilities_url, params: { availability: { availability_status: @availability.availability_status, distance: @availability.distance, end_city: @availability.end_city, end_street_address: @availability.end_street_address, end_zip: @availability.end_zip, lowest_acceptable_price: @availability.lowest_acceptable_price, matched_request_id: @availability.matched_request_id, start_city: @availability.start_city, start_street_address: @availability.start_street_address, start_zip: @availability.start_zip, trip_date: @availability.trip_date, trip_time: @availability.trip_time, user_id: @availability.user_id } }
#     end

#     assert_redirected_to availability_url(Availability.last)
#   end

#   test "should show availability" do
#     get availability_url(@availability)
#     assert_response :success
#   end

#   test "should get edit" do
#     get edit_availability_url(@availability)
#     assert_response :success
#   end

#   test "should update availability" do
#     patch availability_url(@availability), params: { availability: { availability_status: @availability.availability_status, distance: @availability.distance, end_city: @availability.end_city, end_street_address: @availability.end_street_address, end_zip: @availability.end_zip, lowest_acceptable_price: @availability.lowest_acceptable_price, matched_request_id: @availability.matched_request_id, start_city: @availability.start_city, start_street_address: @availability.start_street_address, start_zip: @availability.start_zip, trip_date: @availability.trip_date, trip_time: @availability.trip_time, user_id: @availability.user_id } }
#     assert_redirected_to availability_url(@availability)
#   end

#   test "should destroy availability" do
#     assert_difference('Availability.count', -1) do
#       delete availability_url(@availability)
#     end

#     assert_redirected_to availabilities_url
#   end
end
