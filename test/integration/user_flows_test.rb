require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  fixtures :all
  include Devise::Test::IntegrationHelpers
  
  test "should get home" do
    get '/'
    assert_response :success
    get "/users/sign_in"
    assert_equal 200, status
    sign_in users(:one)
    post "/users/sign_in"
    follow_redirect!
    assert_response :success
  end

  test "should sign in" do
  end

  
end
