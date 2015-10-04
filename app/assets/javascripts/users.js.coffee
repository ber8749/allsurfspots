$ ->
  if $('.users').length
    console.log('users.js loaded')
    google.maps.event.addDomListener(window, 'load', ->
      @googleMap = new GoogleMap({ id: 'google-map' })
      @googleMap.addMarkers(@spots)
    )