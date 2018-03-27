require 'test_helper'

class VenuesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get venues_show_url
    assert_response :success
  end

end
