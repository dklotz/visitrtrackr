require 'rubygems'
require 'geocoder'

class HomeController < ApplicationController
  def remote_ip
    if request.remote_ip == '127.0.0.1'
      # Hard coded remote address
      '77.176.241.91'
    else
      request.remote_ip
    end
  end
  
  def index
    results = Geocoder.search(remote_ip)
    @location = results[0] unless results.empty?
  end
end
