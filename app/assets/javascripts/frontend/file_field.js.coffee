$('.file-field-js').ready ->
  $('input[type=file]').on 'click', ->
    this.value = null

  $('input[type=file]').on 'change', ->
    value = this.value.split(/[\/\\]/).pop()
    wrapper = $(this).parents('.file-field-wrapper')
    wrapper.find('.file-info-wrapper').removeClass('placeholder').removeClass('with-thumbnail').html(value)
    wrapper.find('.upload-button').hide();
    wrapper.find('.remove-button').show();
    wrapper.find('.destroy-flag').val('0');

  $('.remove-button').on 'click', ->
    wrapper = $(this).parents('.file-field-wrapper')
    wrapper.find('.file-info-wrapper').addClass('placeholder').removeClass('with-thumbnail').html(wrapper.data('placeholder'))
    $(this).hide();
    wrapper.find('.upload-button').show();
    wrapper.find('.destroy-flag').val('1');
