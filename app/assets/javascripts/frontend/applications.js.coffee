$('.applications-js').ready ->
  $(".status").change ->
    spinner = $(this).parents('.status-wrapper').find('img')
    spinner.show()
    $.ajax $(this).data('url'),
      type: 'POST',
      data: { status: $(this).val() }
      complete: ->
        spinner.hide()
      error: ->
        alert('Could not change application status. Please refer administrator for any help.')
