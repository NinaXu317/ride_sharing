require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  fixtures :all
  
  test "should get home" do
    get '/'
    assert_response :success
  end

  test "should sign in" do
    get '/users/sign_in'
    assert_response :success
  end

  
end
