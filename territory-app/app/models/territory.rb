class Territory < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :number, :designation
  validates_uniqueness_of :number

end
