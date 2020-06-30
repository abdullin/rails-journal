require 'test_helper'

class JournalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get journals_index_url
    assert_response :success
  end

  test "should get show" do
    get journals_show_url
    assert_response :success
  end

end
