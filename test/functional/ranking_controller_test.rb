require 'test_helper'
require "pp";

class RankingControllerTest < ActionController::TestCase
  test "should get personal" do
    get :personal, {mail_address: "two@example.com", access_token: "two_access_token"}
    assert_response :success
    assert json[0].include?('username')
    assert json[0].include?('rank')
    assert json[0].include?('count')
    assert json[0].include?('created_at')
    pp json
  end

  test "should get general" do
    get :general, {mail_address: "two@example.com", access_token: "two_access_token"}
    assert_response :success
  end

end
