require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  fixtures :users, :requests

  def setup
    @user = users(:one)
    @user2 = users(:two)
    

  end
  #
  test "should login in and go to search page" do
    get '/'
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

  test "rider should login and make request" do
    get '/'
    assert_template 'static_pages/home'
    get new_user_registration_path
    # assert_response 200, status
    @user2.confirm
    sign_in @user2
    post "/users/sign_in"
    assert_redirected_to root_path
    get new_user_request_path(@user2.id)
    assert_template 'requests/_form' 
  end

end
