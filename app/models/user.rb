class User < ActiveRecord::Base
  attr_accessible :mail_address, :username, :life, :level, :total_count, :game_time
  has_one :token_pair
  has_many :rankings

  def self.find_by_mail_address_and_access_token(mail_address, access_token)
    user = self.find_by_mail_address(mail_address)
    return nil if user.nil?
    token_pair = user.token_pair
    return token_pair.present? && token_pair.access_token == access_token ? user : nil
  end

  def next_level
    self.level + 1
  end

  def has_next_level
    APP_CONF['level'].key?(self.next_level)
  end

  def next_level_count
    APP_CONF['level'][self.next_level]['require_count']
  end

  def add_total_count(count)
    attributes = { total_count: (self.total_count + count.to_i) }
    if self.has_next_level && attributes[:total_count] > self.next_level_count
      attributes[:level] = self.next_level
      attributes[:game_time]  = APP_CONF['level'][self.next_level]['game_time']
    end
    self.update_attributes(attributes)
  end
end
