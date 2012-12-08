require 'google/api_client'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_token

  def init_token
    @google_client = Google::APIClient.new
    auth = @google_client.authorization

    auth.client_id     = KEY_CONF['client_id']
    auth.client_secret = KEY_CONF['client_secret']
    auth.scope         = APP_CONF['google_api']['scope']

    auth.redirect_uri = oauth_callback_url
    auth.code = params[:code] if params[:code]
  end

=begin
  def update_token
    if cookies[:access_token]
      @token_pair = TokenPair.find_by_access_token(cookies[:access_token])
      if @token_pair.present?
        @user = @token_pair.user
        auth.update_token!(@token_pair.to_hash)
      end
    end

    if auth.refresh_token && auth.expired?
      auth.fetch_access_token!
      @token_pair.update_token!(auth)
      cookies[:access_token] = auth.access_token
    end
  end
=end

end
