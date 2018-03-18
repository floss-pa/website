# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# added Events Map Marker
$(document).on 'turbolinks:load', ->
  event_latitude = $('#event_latitude').val() || "8.984062"
  event_longitude = $('#event_longitude').val() || "-79.521593"
  elementExists = document.getElementById('show_map')
  if !elementExists?
   console.log('found')
   EventMarker = "Event_marker": L.marker([
     event_latitude
     event_longitude
   ],
     title: 'Mi Evento'
     alt: 'Floss-pa Event'
     draggable: true).addTo(map).on('dragend', ->
     coord = String(EventMarker.getLatLng()).split(',')
     lat = coord[0].split('(')
     $('#event_latitude').val lat[1]
     lng = coord[1].split(')')
     $('#event_longitude').val lng[0]
     EventMarker.bindPopup 'Moved to: ' + lat[1] + ', ' + lng[0] + '.'
     map.panTo new (L.LatLng)(lat[1], lng[0])
     update_event_location = 'https://nominatim.openstreetmap.org/search?format=json&q=' + lat[1] + ',' + lng[0]
     $.getJSON update_event_location, (info) ->
       $('#event_location').val info[0].display_name
       return
     return
    )
   $('#event_location').change ->
    event_location = 'https://nominatim.openstreetmap.org/search?format=json&q=\'' + $('#event_location').val() + '\''
    $.getJSON event_location, (data) ->
      $('#event_latitude').val data[0].lat
      $('#event_longitude').val data[0].lon
      $('#event_location').val data[0].display_name
      newLatLon = new (L.LatLng)(data[0].lat, data[0].lon)
      EventMarker.setLatLng newLatLon
      map.panTo newLatLon
      return
    return
