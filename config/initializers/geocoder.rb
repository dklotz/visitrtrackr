require 'rubygems'
require 'geocoder'

Geocoder.configure(
  # set default units to kilometers:
  :units => :km,

  # simple caching:
  :cache => {}
)
