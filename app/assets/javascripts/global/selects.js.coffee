$ ->
  $('.multiselect').each ->
    $(this).multipleSelect
      placeholder: $(this).data('caption')

  $(".select-wrapper").not(".small").find("select").each ->
    $(this).trigger "change"

$(document).on 'change', '.select-wrapper select', ->
  if $(this).val() is ''
    $(this).removeClass 'selected'
  else
    $(this).addClass 'selected'

$(document).on 'focus', '.select-wrapper select', ->
  $(this).addClass 'selected'

$(document).on 'blur', '.select-wrapper select', ->
  if $(this).val() is ''
    $(this).removeClass 'selected'
  else
    $(this).addClass 'selected'
