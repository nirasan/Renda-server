
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
