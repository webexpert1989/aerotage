module RadiusSearchable
  extend ActiveSupport::Concern

  included do
    scope :within_radius, ->(location, radius_in_miles) {
      radius = radius_in_miles * 1609.34
      select("earth_distance(ll_to_earth(#{location.latitude}, #{location.longitude}), ll_to_earth(locations.latitude, locations.longitude)) AS distance_from_location").
      where('earth_box(ll_to_earth(?, ?), ?) @> ll_to_earth(locations.latitude, locations.longitude)
             AND earth_distance(ll_to_earth(?, ?), ll_to_earth(locations.latitude, locations.longitude)) <= ?',
            location.latitude, location.longitude, radius, location.latitude, location.longitude, radius).
      joins(listing: :location).
      reorder('listings.is_priority DESC, distance_from_location ASC, listings.first_activated_at DESC')
    }
  end

end
