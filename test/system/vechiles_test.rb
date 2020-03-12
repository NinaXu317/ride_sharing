require "application_system_test_case"

class VechilesTest < ApplicationSystemTestCase
  setup do
    @vechile = vechiles(:one)
  end

  test "visiting the index" do
    visit vechiles_url
    assert_selector "h1", text: "Vechiles"
  end

  test "creating a Vechile" do
    visit vechiles_url
    click_on "New Vechile"

    fill_in "License number", with: @vechile.license_number
    fill_in "User", with: @vechile.user_id
    fill_in "Vehicle make", with: @vechile.vehicle_make
    fill_in "Vehicle model", with: @vechile.vehicle_model
    fill_in "Vehicle plate", with: @vechile.vehicle_plate
    click_on "Create Vechile"

    assert_text "Vechile was successfully created"
    click_on "Back"
  end

  test "updating a Vechile" do
    visit vechiles_url
    click_on "Edit", match: :first

    fill_in "License number", with: @vechile.license_number
    fill_in "User", with: @vechile.user_id
    fill_in "Vehicle make", with: @vechile.vehicle_make
    fill_in "Vehicle model", with: @vechile.vehicle_model
    fill_in "Vehicle plate", with: @vechile.vehicle_plate
    click_on "Update Vechile"

    assert_text "Vechile was successfully updated"
    click_on "Back"
  end

  test "destroying a Vechile" do
    visit vechiles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Vechile was successfully destroyed"
  end
end
