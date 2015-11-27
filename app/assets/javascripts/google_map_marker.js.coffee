class @GoogleMapMarker
  constructor: (args) ->
    @lat       = args.lat
    @lng       = args.lng
    @title     = args.title
    @url       = args.url
    @map       = args.map
    @position  = new google.maps.LatLng(@lat, @lng);
    @marker    = new google.maps.Marker(position: @position, map: @map, title: @title, url: @url, icon: '/images/marker.png')
    @location  = null
    # set click functionality
    google.maps.event.addListener(@marker, 'click', () ->
      window.location.href = @url
    )

  address: () ->
    number = @selectComponent('street_number')
    route  = @selectComponent('route')
    if number? then "#{number} #{route}" else route

  city: () ->
    @selectComponent('locality')

  state: () ->
    @selectComponent('administrative_area_level_1')

  country: () ->
    @selectComponent('country')

  continent: () ->
    country = @country()
    for key,value of window.continentCountries()
      if country in value
        return key

  selectComponent: (type) ->
    try
      (component for component in @location.address_components when component.types[0] == type)[0].long_name
    catch error
      console.log "selectComponenent #{type} error: #{error}"
    finally
      ''

  delete: () ->
    @marker.setMap(null)

  reverseGeocode: () =>
    defer = jQuery.Deferred()
    geocoder = new google.maps.Geocoder()
    geocoder.geocode {'latLng': @position}, (results, status) =>
      if status == google.maps.GeocoderStatus.OK
        defer.resolve(results[0])
    defer.promise()

  setLocation: () ->
    @reverseGeocode().done (result) =>
      @location = result