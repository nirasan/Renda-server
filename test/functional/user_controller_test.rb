require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "get exist" do
    
    get :exist
    assert_response :bad_request

    @user1 = users(:one).find
    get :exist, {:mail_address => @user1.mail_address, :access_token => @user1.token_pair.access_token}
    assert_response :not_found
    
    get :exist, {:mail_address => @user1.mail_address + '.jp', :access_token => @user1.token_pair.access_token + '.'}
    assert_response :bad_request
    
    @user2 = users(:two).find
    get :exist, {:mail_address => @user2.mail_address, :access_token => @user2.token_pair.access_token}
    assert_response :success
  end

end
