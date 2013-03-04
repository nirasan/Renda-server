
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
      user.update_attributes(:username => params[:username], :life => APP_CONF["max_life"])
      head :ok
    else
      head :bad_request
    end
  end

  # ユーザーのステータス参照
  def status
    user = User.find_by_mail_address_and_access_token(params[:mail_address], params[:access_token])
    if user.present?
      render :json => user
    else
      head :bad_request
    end
  end

  # カウントの記録
  def update_count
    user = User.find_by_mail_address_and_access_token(params[:mail_address], params[:access_token])
    return head :bad_request if user.nil?

    result = { }

    # カウントをランキングに記録する
    Ranking.add(category: "general",  count: params[:count], user_id:user.id)
    Ranking.add(category: "personal", count: params[:count], user_id:user.id)
    result[:ranking] = 1 #TODO: Ranking.add の返り値を判定する

    # ライフの消費
    new_life = [0, user.life - params[:used_life].to_i].max
    user.update_attributes(:life => new_life)

    # カウント追加＆レベルアップ
    before_level = user.level
    user.add_total_count(params[:count])
    after_level = user.level
    if before_level != after_level
      result[:levelup] = 1
    end
    
    render :json => user.attributes.merge({:rankin => 1})
  end

end
