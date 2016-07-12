$('.show-listing-js').ready ->

  window.showMap = ->
    mapOptions =
      zoom: 11
    window.map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions)

    mapCanvas = $('#map-canvas')
    title = mapCanvas.data('title')
    position = new google.maps.LatLng(mapCanvas.data('latitude'), mapCanvas.data('longitude'))
    window.map.panTo(position)

    marker = new google.maps.Marker(
      position: position
      map: window.map
      title: title)
    infoWindow = new google.maps.InfoWindow(
      content: '<div class="scrollFix">' + title + '</div>'
    )
    google.maps.event.addListener marker, 'click', ->
      infoWindow.open window.map, marker
    infoWindow.open window.map, marker


  $('#map-dialog').fancybox
    wrapCSS: 'fancybox-dialog'
    live: false
    padding: 0
    minWidth: if $(window).width() > 800 then 800 else $(window).width() - 50
    minHeight: if $(window).height() > 500 then 500 else $(window).height() - 50
    helpers:
      title: null
      overlay: locked: true
    afterShow: ->
      loadGoogleMapsScript('showMap')

  $('.listing-tools h1').click ->
    $(this).toggleClass 'expanded'
    $('.listing-tools a').toggleClass 'expanded'
