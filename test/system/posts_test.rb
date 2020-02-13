require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
  end

  test "visiting the index" do
    visit posts_url
    assert_selector "h1", text: "Posts"
  end

  test "creating a Post" do
    visit posts_url
    click_on "New Post"

    fill_in "Destination", with: @post.destination
    fill_in "Distance", with: @post.distance
    fill_in "Post", with: @post.post_id
    fill_in "Start", with: @post.start
    fill_in "Trip date", with: @post.trip_date
    fill_in "Trip time", with: @post.trip_time
    fill_in "User", with: @post.user_id
    click_on "Create Post"

    assert_text "Post was successfully created"
    click_on "Back"
  end

  test "updating a Post" do
    visit posts_url
    click_on "Edit", match: :first

    fill_in "Destination", with: @post.destination
    fill_in "Distance", with: @post.distance
    fill_in "Post", with: @post.post_id
    fill_in "Start", with: @post.start
    fill_in "Trip date", with: @post.trip_date
    fill_in "Trip time", with: @post.trip_time
    fill_in "User", with: @post.user_id
    click_on "Update Post"

    assert_text "Post was successfully updated"
    click_on "Back"
  end

  test "destroying a Post" do
    visit posts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post was successfully destroyed"
  end
end
