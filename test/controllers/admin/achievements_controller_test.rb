require 'test_helper'

class Admin::AchievementsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_achievements_index_url
    assert_response :success
  end

  test "should get award" do
    get admin_achievements_award_url
    assert_response :success
  end

end
