class User < ActiveRecord::Base
  has_secure_password
  has_many :territories
  validates_presence_of :username, :email, :password
  validates_uniqueness_of :username

  def self.valid_params?(params)
    return !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
  end
end
