require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "get exist" do
    
    get :exist
    assert_response :bad_request

    @user1 = users(:one)
    get :exist, {:mail_address => @user1.mail_address, :access_token => @user1.token_pair.access_token}
    assert_response :not_found
    
    get :exist, {:mail_address => @user1.mail_address + '.jp', :access_token => @user1.token_pair.access_token + '.'}
    assert_response :bad_request
    
    @user2 = users(:two)
    get :exist, {:mail_address => @user2.mail_address, :access_token => @user2.token_pair.access_token}
    assert_response :success
  end

  test "update count" do
    
    get :update_count
    assert_response :bad_request

    @user2 = users(:two)
    get :update_count, {:mail_address => @user2.mail_address, :access_token => @user2.token_pair.access_token, :count => 200}
    assert_response :success
    assert json['level'] == 2
    assert json['total_count'] == 200
    assert json['game_time'] == 6

  end

end
