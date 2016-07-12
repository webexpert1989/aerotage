$ ->
  window.currentLocationTargetInput = undefined

  showPosition = (position) ->
    geocoder = new google.maps.Geocoder()
    latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
    geocoder.geocode
      latLng: latlng
    , (results, status) ->
      window.currentLocationTargetInput.removeClass 'ui-autocomplete-loading'
      if status is google.maps.GeocoderStatus.OK
        postalCode = null
        state = null
        $.each results[1]['address_components'], (index, value) ->
          postalCode = value['long_name']  if $.inArray('postal_code', value['types']) isnt -1
          state = value['long_name']  if $.inArray('administrative_area_level_1', value['types']) isnt -1

        window.currentLocationTargetInput.val (if postalCode then postalCode else state)
      else
        alert 'Geocoder failed due to: ' + status

  showError = (error) ->
    window.currentLocationTargetInput.removeClass 'ui-autocomplete-loading'
    switch error.code
      when error.PERMISSION_DENIED
        alert 'User denied the request for Geolocation.'
      when error.POSITION_UNAVAILABLE
        alert 'Location information is unavailable.'
      when error.TIMEOUT
        alert 'The request to get user location timed out.'
      when error.UNKNOWN_ERROR
        alert 'An unknown error occurred.'

  window.getCurrentLocation = ->
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition showPosition, showError
    else
      alert 'Geolocation is not supported by this browser.'

  $('.location-button').on 'click', ->
    loadGoogleMapsScript('getCurrentLocation')
    window.currentLocationTargetInput = $($(this).attr('href'))
    window.currentLocationTargetInput.addClass 'ui-autocomplete-loading'
    false
