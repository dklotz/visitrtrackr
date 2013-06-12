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
    @remote_ip = remote_ip
  end
end
