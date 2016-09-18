Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << "#{Rails.root}/app/assets/fonts"

Rails.application.config.assets.precompile += %w( *.png *.jpg *.jpeg *.gif *.svg *.woff *.woff2)

Rails.application.config.assets.precompile += %w( jquery.min.js bootstrap.min.js svgxuse.js classie.js jquery.mCustomScrollbar.min.js enquire.min.js skrollr.min main.js)
Rails.application.config.assets.precompile += %w( jquery.selectric.min.js contact.js typeahead.js bootstrap-tagsinput.min.js jquery.selectric.min.js job-search.js)