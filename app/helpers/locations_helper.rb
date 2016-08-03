module LocationsHelper

  def smart_caption(location)
    location.city + ', ' + location.state_code + ', ' + location.country_code
  end

  def short_caption(location)
    location.city + ', ' + location.state_code
  end

end
