$('.blog-controls-js').ready ->
  $('.communities #community').change ->
    window.location.pathname = if $(this).val() then 'blog/community/' + $(this).val() else 'blog'
