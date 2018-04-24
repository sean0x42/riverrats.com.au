require 'test_helper'

class Admin::MailingListControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_mailing_list_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_mailing_list_show_url
    assert_response :success
  end

end
