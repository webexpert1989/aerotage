fancyBoxDefaultOptions =
  wrapCSS: "fancybox-dialog"
  parent: 'body'
  padding: 0
  maxWidth: 450
  minWidth: 300
  minHeight: 40
  helpers: { title: null, overlay: { locked: true } }

$ ->
  $(".fancybox").fancybox fancyBoxDefaultOptions
  $(".fancybox-preview").fancybox(padding: 0)

$(document).on "submit", ".ajax-form", ->
  $.fancybox.showLoading()
  $.post $(this).attr("action"), $(this).serialize(), (data) ->
    $.fancybox data, fancyBoxDefaultOptions
    $.fancybox.hideLoading()
    return
  false

$(document).on "page:fetch", ->
  NProgress.start()
  NProgress.set(0.2)

$(document).on "page:change", ->
  NProgress.done()

$(document).on "page:restore", ->
  NProgress.remove()

window.loadGoogleMapsScript = (callback) ->
  if typeof google == 'object' && typeof google.maps == 'object'
    window[callback]()
  else
    script = document.createElement('script')
    script.type = 'text/javascript'
    script.src = 'https://maps.googleapis.com/maps/api/js?v=3.exp&callback=' + callback
    document.body.appendChild script
