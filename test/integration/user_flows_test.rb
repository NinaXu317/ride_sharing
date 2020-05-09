require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  # fixtures :all
  #
  # test "should get home" do
  #   get '/'
  #   assert_response :success
  # end
  #
  # test "should sign in" do
  #   get '/users/sign_in'
  #   assert_response :success
  # end

    test "can login and submit request" do
      get new_user_registration_path
      # assert_equal 200, status
      assert_difference 'User.count', 1 do

      end
      # post "/sessions", params: { email: users(:one).email, password: '111111' }
      # assert_response :redirect
      # follow_redirect!
      # assert_equal "/", path
      # get "/requests/new"
      # assert_equal 200, status
      # assert_equal "/requests/new", path
      # post "/requests", params: { request: { start_city: requests(:one).start_city, start_street_address: requests(:one).start_street_address, end_city: requests(:one).end_city, end_street_address: requests(:one).end_street_address, trip_time: requests(:one).trip_time, highest_price_to_pay: requests(:one).highest_price_to_pay} }
      # assert_equal 301, status # return 500, not 301
      # follow_redirect!
      # assert_equal request_path, path
      assert_template 'registrations#new'
    end
  
end
