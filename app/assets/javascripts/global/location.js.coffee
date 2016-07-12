$(".location-field-js").ready ->
  zipCodeField = $('#zip_code')

  updateLocationFieldAccordingToZipCode = ->
    zipCodeValue = zipCodeField.val()
    if zipCodeValue
      wrapper = $('#location-field-wrapper')
      loading = $('#location-loading-wrapper')
      wrapper.hide()
      loading.show()
      $.get zipCodeField.data('url'),
        zip_code: zipCodeValue
        object: zipCodeField.data('object')
        selected: zipCodeField.data('selected')
      , (data) ->
        if data
          wrapper.html data
          wrapper.find('select').trigger 'change'
          loading.hide()
          wrapper.show()

  zipCodeField.autocomplete
    source: zipCodeField.data('source')
    minLength: 1
    select: (a, b) ->
      $(this).val b.item.value
      updateLocationFieldAccordingToZipCode()
      return

  $('#zip_code').on 'input', ->
    updateLocationFieldAccordingToZipCode()
    return

  updateLocationFieldAccordingToZipCode()
