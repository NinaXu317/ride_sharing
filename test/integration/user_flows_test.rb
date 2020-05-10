require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
<<<<<<< HEAD
  fixtures :all
  
  # test "should get home" do
  #   get root_url
  #   assert_response :success
  # end

  # test "should sign in" do
  #   get root_url
  #   assert_response :success

  #   get '/users/sign_in'
  #   assert_response :success
  # end
=======
  fixtures :users

  def setup
    @user = users(:one)
  end

  test "should login in and go to search page" do
    get '/'
    assert_response :success
    get new_user_registration_path
    assert_equal 200, status
    @user.confirm
    sign_in @user
    post "/users/sign_in"
    assert_redirected_to root_path
    get search_user_requests_url(@user.id)
    assert_equal 200, status
  end
>>>>>>> 5af0b2abf543a2a2f3961009cc6eae3853b443ef

end
