$('.questionnaires-form-js').ready ->
  $("#more_email_present").on "click", ->
    $("#more-email-wrapper").css "display", (if @checked then "block" else "none")

  $("#less_email_present").on "click", ->
    $("#less-email-wrapper").css "display", (if @checked then "block" else "none")
