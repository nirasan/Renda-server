require 'json'

class OauthController < ApplicationController
  def index
    redirect_to @google_client.authorization.authorization_uri.to_s
  end

  def callback
    @google_client.authorization.fetch_access_token!

    result = @google_client.execute(:uri => APP_CONF['google_api']['userinfo_url'])
    response = JSON.parse result.response.body

    mail_address = response["email"]
    access_token = @google_client.authorization.access_token

    #@user = User.find_by_mail_address(mail_address)
    #@user = User.create(:mail_address => mail_address) if @user.nil?
    @user = User.find_or_create_by_mail_address(mail_address)

    #@token_pair = @user.token_pair;
    #@token_pair = TokenPair.create(:user_id => @user.id) if @token_pair.nil?
    @token_pair = TokenPair.find_or_create_by_user_id(@user.id)

    @token_pair.update_token!(@google_client.authorization)

    cookies[:access_token] = access_token
    cookies[:mail_address] = mail_address

    head :ok
  end
end
