class Ranking < ActiveRecord::Base
  attr_accessible :count, :category, :user_id
  belongs_to :user
  
  @@limit = 20

  # ランク入りしたレコードだけ追加
  def self.add(args = {})
    return unless self.has_smaller_count?(args)
    self.create(category: args[:category], user_id: args[:user_id], count: args[:count])
  end

  def self.has_smaller_count?(args = {})
    limit = args[:limit] || @@limit
    rankings = args[:category] == 'personal' ? self.personal_top(user_id: args[:user_id], limit: limit)
                                             : self.general_top(limit: limit)
    return true if rankings.size < limit
    return rankings.last.count <= args[:count] 
  end

  # ランク外のレコードを削除する
  def self.delete(category, limit)
  end

  def self.personal_top(args = {})
    where("category = 'personal' and user_id = ?", args[:user_id]).includes(:user).order("count desc").limit(args[:limit] || @@limit)
  end

  def self.general_top(args = {})
    where("category = 'general'").includes(:user).order("count desc").limit(args[:limit] || @@limit)
  end
end
