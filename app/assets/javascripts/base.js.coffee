jQuery ->
  $('.magnific-image').magnificPopup(type:'image')  # single image popup

  $('.magnific-gallery-item').magnificPopup(
    type: 'image',
    gallery:
      enabled:true
    )

  $('.expander').click ->
    $(this).siblings('.expandable').slideToggle()