$(document).ready ->
  # Initialize the jQuery File Upload widget:

  # Uncomment the following to send cross-domain cookies:
  #xhrFields: {withCredentials: true},
  $("#fileupload").fileupload 
    url: "/photos/upload"
    acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i