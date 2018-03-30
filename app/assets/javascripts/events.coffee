# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# added Events Map Marker
$(document).on 'turbolinks:load', ->
  event_latitude = $('#event_latitude').val() || "8.984062"
  event_longitude = $('#event_longitude').val() || "-79.521593"
  if ($('#map').get(0) && !$('#show_map').get(0))
   EventMarker = L.marker([
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
  $('#event_image').change( ->
     file = @files[0]
     # This code is only for demo ...
     previewImage(this.files[0])
     img = $('#image')
     img.load( ->
       height = this.naturalHeight;
       width = this.naturalWidth;
       view_height = this.height
       view_width = this.width
       $('#event_crop_vy').val(view_height)
       crop_height = parseInt(view_height * (600 / height))
       crop_width = parseInt(view_width * (1200 / width))
       start_width = parseInt(view_width/2 - crop_width/2) 
       end_width = start_width + crop_width
       start_height = parseInt(view_height/2 - crop_height/2)
       end_height = start_height + crop_height
       img.Jcrop({
        bgColor: 'black',
        minSize: [crop_width,crop_height],
        maxSize: [crop_width,crop_height],
        setSelect: [start_width, start_height, end_width, end_height],
        bgOpacity: .6,
        onChange: showCords,
        onSelect: showCords
       });
      )
    )
  false
  previewImage = (file) ->
    previewId = '#Preview'
    preview = $(previewId)
    imageType = /image.*/
    if !file.type.match(imageType)
      throw 'File Type must be an image'
    thumb = document.createElement('div')
    thumb.classList.add 'thumbnail'
    # Add the class thumbnail to the created div
    img = document.createElement('img')
    img.id = 'image'
    img.file = file
    thumb.appendChild img
    preview.html( thumb)
    # Using FileReader to display the image content
    reader = new FileReader
    reader.onload = ((aImg) ->
      (e) ->
        aImg.src = e.target.result
        return
    )(img)
    reader.readAsDataURL file
    return
  showCords = (coords) ->
   $('#event_crop_x').val(coords.x);
   $('#event_crop_y').val(coords.y);
   $('#event_crop_x2').val(coords.x2);
   $('#event_crop_y2').val(coords.y2);
   $('#event_crop_w').val(coords.w);
   $('#event_crop_h').val(coords.h);

