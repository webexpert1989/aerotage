class Location < ActiveRecord::Base

  def self.search_listings_with_location(target_class, conditions)
    smart_location = conditions['smart_location_eq'] ? conditions.delete('smart_location_eq').strip : nil
    radius = conditions['smart_location_radius'] ? conditions.delete('smart_location_radius').to_i : nil

    if smart_location.present?

      if smart_location.include?(',')
        parts = smart_location.split(',')

        if parts.size == 2
          city = parts.first.strip
          state_code = parts.second.strip

          location = Location.search(city_matches: city, state_code_matches: state_code).result.first

          if location.present?
            if radius.present?
              conditions['smart_location'] = 'within ' + radius.to_s + ' miles of ' + location.city + ', ' + location.state
              return target_class.ransack(conditions).result.within_radius(location, radius)
            else
              conditions['listing_location_id_eq'] = location.id
            end
          else
            conditions['listing_location_city_matches'] = smart_location
          end
        else
          conditions['listing_location_city_matches'] = smart_location
        end
      elsif (location = Location.search(state_matches: smart_location).result.first).present?
        conditions['listing_location_state_eq'] = location.state
      elsif (location = Location.search(country_matches: smart_location).result.first).present?
        conditions['listing_location_country_eq'] = location.country
      elsif (location = Location.search(zip_code_matches: smart_location).result.first).present?
        if radius.present?
          conditions['smart_location'] = 'within ' + radius.to_s + ' miles of ' + location.zip_code
          return target_class.ransack(conditions).result.within_radius(location, radius)
        else
          conditions['listing_location_id_eq'] = location.id
        end
      else
        conditions['listing_location_city_matches'] = smart_location
      end

    end

    target_class.ransack(conditions).result
  end

end
