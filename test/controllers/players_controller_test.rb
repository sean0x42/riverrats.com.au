require 'test_helper'

class PlayersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get players_show_url
    assert_response :success
  end

end
