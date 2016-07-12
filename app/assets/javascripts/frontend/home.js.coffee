$('.home-js').ready ->
  tabs = $("#tabs")
  tabs.find("ul a").click ->
    tabs.find("> div").hide()
    tabs.find($(this).attr("href")).show()
    tabs.find("ul a").removeClass "active"
    $(this).addClass "active"
    false

  tabs.find("ul a").first().click()

  $('.bxslider').removeClass('hidden').bxSlider(
    auto: true,
    autoHover: true,
    slideMargin: 20
  )
