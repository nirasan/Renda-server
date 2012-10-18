class User < ActiveRecord::Base
  attr_accessible :password, :score, :username

  validates :username,
    :presence => true,
    :uniqueness => true
  
  validates :password,
    :presence => true
end
