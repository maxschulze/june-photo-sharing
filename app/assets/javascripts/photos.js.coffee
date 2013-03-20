$(document).ready ->
  # Initialize the jQuery File Upload widget:

  # Uncomment the following to send cross-domain cookies:
  #xhrFields: {withCredentials: true},
  $("#fileupload").fileupload 
    url: "/photos/upload"
    acceptFileTypes: /(\.|\/)(jpe?g)$/i
		
	###
	Adds 0 left margin to the first thumbnail on each row that don't get it via CSS rules.
	Recall the function when the floating of the elements changed.
	###
	fixThumbnailMargins = ->
	  $(".row-fluid .thumbnails").each ->
	    $thumbnails = $(this).children()
	    previousOffsetLeft = $thumbnails.first().offset().left
	    $thumbnails.removeClass "first-in-row"
	    $thumbnails.first().addClass "first-in-row"
	    $thumbnails.each ->
	      $thumbnail = $(this)
	      offsetLeft = $thumbnail.offset().left
	      $thumbnail.addClass "first-in-row"  if offsetLeft < previousOffsetLeft
	      previousOffsetLeft = offsetLeft

	# Fix the margins when potentally the floating changed
	$(window).resize fixThumbnailMargins
	fixThumbnailMargins()