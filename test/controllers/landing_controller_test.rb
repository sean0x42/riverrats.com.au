require 'test_helper'

class LandingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get landing_index_url
    assert_response :success
  end

  test "should get privacy_policy" do
    get landing_privacy_policy_url
    assert_response :success
  end

end
