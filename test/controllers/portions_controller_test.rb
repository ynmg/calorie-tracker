require "test_helper"

class PortionsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get portions_update_url
    assert_response :success
  end

  test "should get show" do
    get portions_show_url
    assert_response :success
  end
end
