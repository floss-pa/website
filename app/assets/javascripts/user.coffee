# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('#user_avatar').change( ->
     file = @files[0]
     # This code is only for demo ...
     UserpreviewImage(this.files[0])
     img = $('#userimage')
     img.load( ->
       height = this.naturalHeight;
       width = this.naturalWidth;
       view_height = this.height
       view_width = this.width
       $('#user_crop_vy').val(view_height)
       crop_height = parseInt(view_height * (400 / height))
       crop_width = parseInt(view_width * (400 / width))
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
        onChange: UsershowCords,
        onSelect: UsershowCords
       });
      )
    )
  false
  UserpreviewImage = (file) ->
    previewId = '#UserPreview'
    preview = $(previewId)
    imageType = /image.*/
    if !file.type.match(imageType)
      throw 'File Type must be an image'
    thumb = document.createElement('div')
    thumb.classList.add 'thumbnail'
    # Add the class thumbnail to the created div
    img = document.createElement('img')
    img.id = 'userimage'
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
  UsershowCords = (coords) ->
   $('#user_crop_x').val(coords.x);
   $('#user_crop_y').val(coords.y);
   $('#user_crop_x2').val(coords.x2);
   $('#user_crop_y2').val(coords.y2);
   $('#user_crop_w').val(coords.w);
   $('#user_crop_h').val(coords.h);

