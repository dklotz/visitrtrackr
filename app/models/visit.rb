class Visit < ActiveRecord::Base
  attr_accessible :useragent, :lat, :long
  
  validates :useragent,  :presence => true, :length => { :minimum => 3 }
  validates :lat, :presence => true
  validates :long, :presence => true
end
