$(".registration-form-js").ready ->
  $(".info-popup").fancybox
    wrapCSS: "fancybox-dialog"
    parent: 'body'
    type: "ajax"
    maxWidth: 800
    padding: 0
    helpers:
      title: null
      overlay:
        locked: true
