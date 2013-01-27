
class RankingController < ApplicationController
  
  def personal
    user = User.find_by_mail_address_and_access_token(params[:mail_address], params[:access_token])
    return head :bad_request unless user.present?
    
    data = _make_ranking_data(Ranking.personal_top(user_id: user.id))
    render :json => data
  end

  def general
    user = User.find_by_mail_address_and_access_token(params[:mail_address], params[:access_token])
    return head :bad_request unless user.present?

    data = _make_ranking_data(Ranking.general_top)
    render :json => data
  end

  # 順位をつける
  # countが同じなら同順に
  def _make_ranking_data(rankings)
    rank       ||= 0
    real_rank  ||= 0
    prev_count ||= 0
    return rankings.map do |r|
      real_rank += 1
      if r.count != prev_count
        rank = real_rank
      end
      prev_count = r.count
      {username: r.user.username, count: r.count, rank: rank, created_at: r.created_at}
    end
  end
end
