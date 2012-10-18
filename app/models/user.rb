class User < ActiveRecord::Base
  attr_accessible :password, :score, :username
end
