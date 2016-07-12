$ ->
  $("#modify-search-button").click ->
    $("#search-dropdown-trigger").trigger "click"
    $(".advanced-search-form").show "fast", ->
      $(".multi-select-wrapper select").multipleSelect "refresh"
    false

  $(".advanced-search-link").click ->
    $(this).toggleClass "expanded"
    $(".advanced-search-form").slideToggle "fast"
    $(".multi-select-wrapper select").multipleSelect "refresh"
    false

  $(".search-radius a").click ->
    $(".search-radius a").removeClass "selected"
    $(this).addClass "selected"
    $("#radius").val $(this).html()
    false
