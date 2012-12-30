require 'test_helper'

class RankingControllerTest < ActionController::TestCase
  test "should get personal" do
    get :personal
    assert_response :success
  end

  test "should get general" do
    get :general
    assert_response :success
  end

end
