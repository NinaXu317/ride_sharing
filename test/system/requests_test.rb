require "application_system_test_case"

class RequestsTest < ApplicationSystemTestCase
  setup do
    @request = requests(:one)
  end

  test "visiting the index" do
    visit requests_url
    assert_selector "h1", text: "Requests"
  end

  test "creating a Request" do
    visit requests_url
    click_on "New Request"

    fill_in "Distance", with: @request.distance
    fill_in "End city", with: @request.end_city
    fill_in "End street address", with: @request.end_street_address
    fill_in "End zip", with: @request.end_zip
    fill_in "Highest price to pay", with: @request.highest_price_to_pay
    fill_in "Matched availability", with: @request.matched_availability_id
    fill_in "Request status", with: @request.request_status
    fill_in "Start city", with: @request.start_city
    fill_in "Start street address", with: @request.start_street_address
    fill_in "Start zip", with: @request.start_zip
    fill_in "Trip date", with: @request.trip_date
    fill_in "Trip time", with: @request.trip_time
    fill_in "User", with: @request.user_id
    click_on "Create Request"

    assert_text "Request was successfully created"
    click_on "Back"
  end

  test "updating a Request" do
    visit requests_url
    click_on "Edit", match: :first

    fill_in "Distance", with: @request.distance
    fill_in "End city", with: @request.end_city
    fill_in "End street address", with: @request.end_street_address
    fill_in "End zip", with: @request.end_zip
    fill_in "Highest price to pay", with: @request.highest_price_to_pay
    fill_in "Matched availability", with: @request.matched_availability_id
    fill_in "Request status", with: @request.request_status
    fill_in "Start city", with: @request.start_city
    fill_in "Start street address", with: @request.start_street_address
    fill_in "Start zip", with: @request.start_zip
    fill_in "Trip date", with: @request.trip_date
    fill_in "Trip time", with: @request.trip_time
    fill_in "User", with: @request.user_id
    click_on "Update Request"

    assert_text "Request was successfully updated"
    click_on "Back"
  end

  test "destroying a Request" do
    visit requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Request was successfully destroyed"
  end
end
