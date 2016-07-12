$('.listing-print-js').ready ->
  $('#print-button input').click ->
    $(this).hide()
    window.print()
