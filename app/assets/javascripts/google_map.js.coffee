# Global GoogleMap class
class @GoogleMap
  constructor: (@args) ->
    @id      = @args.id   || 'google-map'
    @zm      = @args.zoom || 2
    @lat     = @args.lat  || 0
    @lng     = @args.lng  || 0
    @el      = document.getElementById(@id)
    @ctr     = new google.maps.LatLng(@lat, @lng)
    @opts    = { center: @ctr, zoom: @zm, mapTypeId: google.maps.MapTypeId.HYBRID }
    @map     = new google.maps.Map(@el,@opts)
    @markers = []

  addMarker: (marker) ->
    @markers.push new GoogleMapMarker(lat: marker.lat, lng: marker.lng, title: marker.name, url: marker.url, map: @map)

  addMarkers: (markers) ->
    for marker in markers
      @addMarker(marker)

  deleteMarkers: () ->
    for marker in @markers
      marker.delete()
    @markers = []