require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  fixtures :users

  def setup
    @user = users(:one)
  end
  #
  test "should login in and go to search page" do
    get '/'
    assert_response :success
<<<<<<< HEAD
    get '/users/sign_in'
    assert_response :success
=======
    get new_user_registration_path
    assert_response 200, status
>>>>>>> 31e27bfb1ad3f6ee5aa0b605d25348d813060d12
    @user.confirm
    sign_in @user
    post "/users/sign_in"
    assert_redirected_to root_path
    get search_user_requests_url(@user.id)
    # assert_equal 200, status
  end

end
