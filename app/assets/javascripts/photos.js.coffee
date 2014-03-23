$(document).ready ->
  # Initialize the jQuery File Upload widget:

  # Uncomment the following to send cross-domain cookies:
  #xhrFields: {withCredentials: true},
  $("#fileupload").fileupload
    url: $('#fileupload').attr('action')
    acceptFileTypes: /(\.|\/)(jpe?g)$/i

  ###
	Adds 0 left margin to the first thumbnail on each row
  that don't get it via CSS rules.
	Recall the function when the floating of the elements changed.
  ###
  fixThumbnailMargins = ->
    return if $(".home .thumbnails.albums").length == 0

    $(".home .thumbnails.albums").each ->
      $thumbnails = $(this).children()

      if $thumbnails.length > 0
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
  $(window).on 'load', fixThumbnailMargins
  window.setTimeout ->
    fixThumbnailMargins()
  , 100

  $('input[data-behaviour="datepicker"]').datepicker()

  $('textarea.expandable').bind 'keyup', ->
    console.log 'up'
    $(this).css height: 0
    $(this).css
      overflow: 'hidden'
      height: @.scrollHeight