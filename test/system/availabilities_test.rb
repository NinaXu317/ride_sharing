require "application_system_test_case"

class AvailabilitiesTest < ApplicationSystemTestCase
  setup do
    @availability = availabilities(:one)
  end

  test "visiting the index" do
    visit availabilities_url
    assert_selector "h1", text: "Availabilities"
  end

  test "creating a Availability" do
    visit availabilities_url
    click_on "New Availability"

    fill_in "Availability status", with: @availability.availability_status
    fill_in "Distance", with: @availability.distance
    fill_in "End city", with: @availability.end_city
    fill_in "End street address", with: @availability.end_street_address
    fill_in "End zip", with: @availability.end_zip
    fill_in "Lowest acceptable price", with: @availability.lowest_acceptable_price
    fill_in "Matched request", with: @availability.matched_request_id
    fill_in "Start city", with: @availability.start_city
    fill_in "Start street address", with: @availability.start_street_address
    fill_in "Start zip", with: @availability.start_zip
    fill_in "Trip date", with: @availability.trip_date
    fill_in "Trip time", with: @availability.trip_time
    fill_in "User", with: @availability.user_id
    click_on "Create Availability"

    assert_text "Availability was successfully created"
    click_on "Back"
  end

  test "updating a Availability" do
    visit availabilities_url
    click_on "Edit", match: :first

    fill_in "Availability status", with: @availability.availability_status
    fill_in "Distance", with: @availability.distance
    fill_in "End city", with: @availability.end_city
    fill_in "End street address", with: @availability.end_street_address
    fill_in "End zip", with: @availability.end_zip
    fill_in "Lowest acceptable price", with: @availability.lowest_acceptable_price
    fill_in "Matched request", with: @availability.matched_request_id
    fill_in "Start city", with: @availability.start_city
    fill_in "Start street address", with: @availability.start_street_address
    fill_in "Start zip", with: @availability.start_zip
    fill_in "Trip date", with: @availability.trip_date
    fill_in "Trip time", with: @availability.trip_time
    fill_in "User", with: @availability.user_id
    click_on "Update Availability"

    assert_text "Availability was successfully updated"
    click_on "Back"
  end

  test "destroying a Availability" do
    visit availabilities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Availability was successfully destroyed"
  end
end
