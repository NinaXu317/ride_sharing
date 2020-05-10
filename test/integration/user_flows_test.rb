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
    get '/users/sign_in'
    assert_response :success
    @user.confirm
    sign_in @user
    post "/users/sign_in"
    assert_redirected_to root_path
    get search_user_requests_url(@user.id)
    # assert_equal 200, status
  end

end
