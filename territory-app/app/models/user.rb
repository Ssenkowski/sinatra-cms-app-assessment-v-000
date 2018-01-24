class User < ActiveRecord::Base
  has_secure_password
  has_many :territories
  validates_presence_of :username, :email, :password
  validates_uniqueness_of :username

end
