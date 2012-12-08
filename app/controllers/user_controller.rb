
class UserController < ApplicationController
  
  # ユーザーの存在確認
  def exist
    user = User.find_by_mail_address_and_access_token(params[:mail_address], params[:access_token])
    if user.present?
      head user.username.present? ? :ok : :not_found
    else
      head :bad_request
    end
  end

  # ユーザーの登録
  def register
    user = User.find_by_mail_address_and_access_token(params[:mail_address], params[:access_token])
    if user.present?
      user.update_attributes(:username => params[:username])
      head :ok
    else
      head :bad_request
    end
  end

  def edit
    @user = User.find_by_username_and_password(params[:username], params[:password])
    if @user.present?
      score = @user.score + params[:score].to_i;
     @user.update_attributes(:score => score);
      render :json => @user
    else
      head :not_found
    end
  end

  def ranking
    @users = User.order("score desc")
    render :json => @users;
  end
end
