class Visit < ActiveRecord::Base
  attr_accessible :useragent, :latitude, :longitude
  
  validates :useragent,  :presence => true, :length => { :minimum => 3 }
  validates :latitude,  :presence => true, 
                        :numericality => {  :greater_than_or_equal_to => -90.0, 
                                            :less_than_or_equal_to => 90.0 }
  validates :longitude, :presence => true, 
                        :numericality => {  :greater_than_or_equal_to => -180.0, 
                                            :less_than_or_equal_to => 180.0 }
end
