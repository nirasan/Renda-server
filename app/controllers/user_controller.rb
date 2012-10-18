
class UserController < ApplicationController
  def show
    @user = User.find_by_username_and_password(params[:username], params[:password])
    if @user.present?
      render :json => @user
    else
      head :not_found
    end
  end

  def add
    @user = User.new(:username => params[:username], :password => params[:password])
    if @user.save
      head :ok
    else
      head :bad_request
    end
  end
end
