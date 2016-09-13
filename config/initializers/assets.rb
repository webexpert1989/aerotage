# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( admin.js admin.css *.png *.jpg *.jpeg *.gif)
Rails.application.config.assets.precompile += %w( jquery.min.js bootstrap.min.js svgxuse.js classie.js jquery.mCustomScrollbar.min.js enquire.min.js skrollr.min main.js)
Rails.application.config.assets.precompile += %w( jquery.selectric.min.js contact.js typeahead.js bootstrap-tagsinput.min.js jquery.selectric.min.js job-search.js)