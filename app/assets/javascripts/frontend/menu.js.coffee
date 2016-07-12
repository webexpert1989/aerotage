$ ->
  $("#search-dropdown-trigger").click ->
    $(this).toggleClass "active"
    $("#search-dropdown").toggle()
    $(".multi-select-wrapper select").multipleSelect "refresh"
    false

  $(".menu-button").click ->
    $(".user-menu").toggleClass "xs-opened"  unless $("nav.left-menu").hasClass("xs-opened")
    $("nav.left-menu").toggleClass "xs-opened"
    false

  $(".user-menu-toggle").click ->
    if $(".user-menu").css("top") is "0px"
      $(".user-menu").toggleClass "opened"
      $(".user-menu").toggleClass "xs-opened"
      false
