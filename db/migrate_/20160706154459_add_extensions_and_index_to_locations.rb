class AddExtensionsAndIndexToLocations < ActiveRecord::Migration
  def change
    enable_extension 'cube'
    enable_extension 'earthdistance'

    reversible do |direction|
      direction.up { execute 'CREATE INDEX geo_location ON locations USING gist(ll_to_earth(latitude, longitude));' }
    end
  end
end
