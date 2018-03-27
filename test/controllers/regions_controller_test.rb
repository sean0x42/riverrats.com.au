require 'test_helper'

class RegionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get regions_show_url
    assert_response :success
  end

end
