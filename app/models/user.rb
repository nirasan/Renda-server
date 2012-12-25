class User < ActiveRecord::Base
  attr_accessible :mail_address, :username, :life
  has_one :token_pair
  has_meny :rankings

  def self.find_by_mail_address_and_access_token(mail_address, access_token)
    user = self.find_by_mail_address(mail_address)
    return if user.nil?
    token_pair = user.token_pair
    return token_pair.present? && token_pair.access_token == access_token ? user : nil
  end
end
