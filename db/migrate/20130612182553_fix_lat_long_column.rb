# Renames the lat/long fields of visits to latitude/longitude to comply
# with the default names used by the 'geocoder' gem.

class FixLatLongColumn < ActiveRecord::Migration
  def change
    rename_column :visits, :lat, :latitude
    rename_column :visits, :long, :longitude
  end
end
