require 'test_helper'

class Admin::PlayersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_players_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_players_show_url
    assert_response :success
  end

  test "should get new" do
    get admin_players_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_players_edit_url
    assert_response :success
  end

end
