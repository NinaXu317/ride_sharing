require 'test_helper'

class VechilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vechile = vechiles(:one)
  end

  test "should get index" do
    get vechiles_url
    assert_response :success
  end

  test "should get new" do
    get new_vechile_url
    assert_response :success
  end

  test "should create vechile" do
    assert_difference('Vechile.count') do
      post vechiles_url, params: { vechile: { license_number: @vechile.license_number, user_id: @vechile.user_id, vehicle_make: @vechile.vehicle_make, vehicle_model: @vechile.vehicle_model, vehicle_plate: @vechile.vehicle_plate } }
    end

    assert_redirected_to vechile_url(Vechile.last)
  end

  test "should show vechile" do
    get vechile_url(@vechile)
    assert_response :success
  end

  test "should get edit" do
    get edit_vechile_url(@vechile)
    assert_response :success
  end

  test "should update vechile" do
    patch vechile_url(@vechile), params: { vechile: { license_number: @vechile.license_number, user_id: @vechile.user_id, vehicle_make: @vechile.vehicle_make, vehicle_model: @vechile.vehicle_model, vehicle_plate: @vechile.vehicle_plate } }
    assert_redirected_to vechile_url(@vechile)
  end

  test "should destroy vechile" do
    assert_difference('Vechile.count', -1) do
      delete vechile_url(@vechile)
    end

    assert_redirected_to vechiles_url
  end
end
