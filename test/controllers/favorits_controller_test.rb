require 'test_helper'

class FavoritsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get favorits_create_url
    assert_response :success
  end

  test "should get destroy" do
    get favorits_destroy_url
    assert_response :success
  end

end
