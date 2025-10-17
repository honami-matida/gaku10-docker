require "test_helper"

class Public::StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get terms" do
    get public_static_pages_terms_url
    assert_response :success
  end
end
