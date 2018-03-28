require 'test_helper'

class Admin::VenuesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_venues_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_venues_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_venues_edit_url
    assert_response :success
  end

end
