require 'test_helper'

class Admin::GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_games_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_games_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_games_edit_url
    assert_response :success
  end

end
