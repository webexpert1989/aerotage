$('.questionnaire-questions-form-js').ready ->
  $("input[name='questionnaire_question[answer_type]']").on "change", ->
    value = $(this).val()
    if value == 'text'
      $('#yes-no, #answers').hide()
    else if value == 'yes_no'
      $('#answers').hide()
      $('#yes-no').show()
    else
      $('#yes-no').hide()
      $('#answers').show()

  $('#add-answer-block').on 'click', ->
    block = $('#answer-placeholder > div').clone()
    $('#answers-list').append(block)
    false

  $('#answers-list').on 'click', '.delete-answer-block', ->
    $(this).parents('.row').remove()
    false
