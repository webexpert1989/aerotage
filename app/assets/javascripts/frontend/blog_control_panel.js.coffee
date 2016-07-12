$('.blog-control-panel').ready ->
  $('.community-trigger').click ->
    $('.blog-control-panel .blog-search').hide();
    $('.blog-control-panel .communities').show();

  $('.blog-search-trigger').click ->
    $('.blog-control-panel .communities').hide();
    $('.blog-control-panel .blog-search').show();
