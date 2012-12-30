
class RankingController < ApplicationController
  def personal
    user = User.find_by_mail_address_and_access_token(params[:mail_address], params[:access_token])
    return head :bad_request unless user.present?

    rankings = Ranking.personal_top(user_id: user.id)

    # 順位をつける
    # countが同じなら同順に
    rank       ||= 0
    real_rank  ||= 0
    prev_count ||= 0
    data = rankings.map do |r|
      real_rank += 1
      if r.count != prev_count
        rank = real_rank
      end
      prev_count = r.count
      {username: r.user.username, count: r.count, rank: rank}
    end

    render :json => data
  end

  def general
  end
end
