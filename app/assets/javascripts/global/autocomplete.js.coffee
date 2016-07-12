$ ->
  $('.with-autocomplete').each ->
    $(this).autocomplete
      source: $(this).data('source')
      minLength: 2
