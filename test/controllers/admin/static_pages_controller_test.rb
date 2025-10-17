require "test_helper"

class Admin::StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get terms" do
    get admin_static_pages_terms_url
    assert_response :success
  end
end
