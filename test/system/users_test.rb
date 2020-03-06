require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test "visiting the index" do
    visit users_url
    assert_selector "h1", text: "Users"
  end

  test "creating a User" do
    visit users_url
    click_on "New User"

    fill_in "Age", with: @user.age
    fill_in "Email", with: @user.email
    fill_in "Firstname", with: @user.firstname
    fill_in "Gender", with: @user.gender
    check "Is driver" if @user.is_driver
    fill_in "Lastname", with: @user.lastname
    fill_in "Major", with: @user.major
    fill_in "Number of rating given", with: @user.number_of_rating_given
    fill_in "Number of rating received", with: @user.number_of_rating_received
    fill_in "Phone number", with: @user.phone_number
    fill_in "Sum of rating given", with: @user.sum_of_rating_given
    fill_in "Sum of rating received", with: @user.sum_of_rating_received
    fill_in "Username", with: @user.username
    fill_in "Year", with: @user.year
    click_on "Create User"

    assert_text "User was successfully created"
    click_on "Back"
  end

  test "updating a User" do
    visit users_url
    click_on "Edit", match: :first

    fill_in "Age", with: @user.age
    fill_in "Email", with: @user.email
    fill_in "Firstname", with: @user.firstname
    fill_in "Gender", with: @user.gender
    check "Is driver" if @user.is_driver
    fill_in "Lastname", with: @user.lastname
    fill_in "Major", with: @user.major
    fill_in "Number of rating given", with: @user.number_of_rating_given
    fill_in "Number of rating received", with: @user.number_of_rating_received
    fill_in "Phone number", with: @user.phone_number
    fill_in "Sum of rating given", with: @user.sum_of_rating_given
    fill_in "Sum of rating received", with: @user.sum_of_rating_received
    fill_in "Username", with: @user.username
    fill_in "Year", with: @user.year
    click_on "Update User"

    assert_text "User was successfully updated"
    click_on "Back"
  end

  test "destroying a User" do
    visit users_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User was successfully destroyed"
  end
end
