require 'test_helper'

class ReviewControllerTest < ActionDispatch::IntegrationTest
  test "should get week" do
    get review_week_url
    assert_response :success
  end

end
