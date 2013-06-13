require 'rubygems'
require 'geocoder'

class HomeController < ApplicationController
  def remote_ip
    if request.remote_ip == '127.0.0.1'
      # Hard coded remote address
      '77.176.241.91'
      #'173.194.69.99'
      #''
    else
      request.remote_ip
    end
  end
  
  def get_location
    results = Geocoder.search(remote_ip)
    if results.empty?
      location = {  :address => 'Unknown',
                    :latitude => 0.0,
                    :longitude => 0.0 }
    else
      location = {  :address => results[0].city + ", " + results[0].country_code,
                    :latitude => results[0].latitude,
                    :longitude => results[0].longitude }
    end
    return location
  end
  
  def index
    @location = get_location
    @user_agent = request.user_agent
  end
end
