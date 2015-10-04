$ ->
  if $('.spots').length
    console.log('spots.js loaded')
    google.maps.event.addDomListener(window, 'load', ->
      options = { id: 'google-map' }
      if $('.spots.index').length
        lat = $('#google-map').data('lat')
        lng = $('#google-map').data('lng')
        jQuery.extend options, { zoom: 4, lat: lat, lng: lng }
      if $('.spots.show, .spots.edit').length
        jQuery.extend options, { zoom: 16, lat: @spots[0].lat, lng: @spots[0].lng }
      @googleMap = new GoogleMap(options)
      @googleMap.addMarkers(@spots)

      if $('.spots.new, .spots.edit').length
        google.maps.event.addListener(@googleMap.map, 'rightclick', (event) =>
          @googleMap.deleteMarkers()
          @googleMap.addMarkers([lat: event.latLng.lat(), lng: event.latLng.lng()])
          marker = @googleMap.markers[0]
          marker.setLocation()
          # set form elements with marker value
          $('#spot_lat').val(marker.lat)
          $('#spot_lng').val(marker.lng)
          setTimeout =>   # janky way of dealing with async reverse geocoding
            $('#spot_continent').val(marker.continent()).change()
          , 1000
          setTimeout =>
            $('#spot_country').val(marker.country()).change()
          , 1500
          setTimeout =>
            $('#spot_state').val(marker.state()).change()
            $('#spot_address').val(marker.address())
            $('#spot_city').val(marker.city())
          , 2000
        )

        $('#spot_continent').change ->
          $.ajax '/spots/country_options',
            type: 'GET'
            dataType: 'script'
            data:
              continent: $('#spot_continent option:selected').val()
            error: (jqXHR, textStatus, errorThrown) ->
              console.log("AJAX Error: #{textStatus}")
            success: (data, textStatus, jqXHR) ->
              console.log("Dynamic country select OK!")

        $('#spot_country').change ->
          $.ajax '/spots/state_options',
            type: 'GET'
            dataType: 'script'
            data:
              country: $('#spot_country option:selected').val()
            error: (jqXHR, textStatus, errorThrown) ->
              console.log("AJAX Error: #{textStatus}")
            success: (data, textStatus, jqXHR) ->
              console.log("Dynamic state select OK!")
    )