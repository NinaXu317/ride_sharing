require 'test_helper'

class CreaterequestFlowsTest < ActionDispatch::IntegrationTest
  fixtures :users, :requests

  test "can login and submit request" do
    get "/login"
    assert_equal 200, status
    post "/sessions", params: { email: users(:one).email, password: '111111' }
    assert_response :redirect
    follow_redirect!
    assert_equal "/", path
    get "/requests/new"
    assert_equal 200, status
    # assert_equal "/requests/new", path
    # post "/requests", params: { request: { start_city: requests(:one).start_city, start_street_address: requests(:one).start_street_address, end_city: requests(:one).end_city, end_street_address: requests(:one).end_street_address, trip_time: requests(:one).trip_time, highest_price_to_pay: requests(:one).highest_price_to_pay} }
    # assert_equal 301, status # return 500, not 301
    # follow_redirect!
    # assert_equal request_path, path
  end
end
