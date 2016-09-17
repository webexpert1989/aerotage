Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w( admin.js admin.css *.png *.jpg *.jpeg *.gif *.svg)
Rails.application.config.assets.precompile += %w( jquery.min.js bootstrap.min.js svgxuse.js classie.js jquery.mCustomScrollbar.min.js enquire.min.js skrollr.min main.js)
Rails.application.config.assets.precompile += %w( jquery.selectric.min.js contact.js typeahead.js bootstrap-tagsinput.min.js jquery.selectric.min.js job-search.js)