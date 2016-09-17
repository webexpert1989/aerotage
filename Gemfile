source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '4.2.5'
gem 'sass-rails', '~> 5.0'
gem 'compass-rails'
gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'uglifier', '>= 1.3.0'
gem 'yui-compressor'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'fancybox2-rails', '~> 0.2.8'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'harvested', '~> 3.1', '>= 3.1.1'
gem 'bootstrap-sass'
gem 'high_voltage'
gem 'pg'
gem 'puma'
gem 'pundit'
gem 'sendgrid'
gem 'devise'
gem 'active_record-acts_as'
gem 'acts_as_list'
gem 'haml-rails'
gem 'ancestry'
gem 'bcrypt'
gem 'bxslider-rails'
gem 'cocoon'
gem 'dragonfly'
gem 'dragonfly-s3_data_store'
gem 'faker'
gem 'friendly_id'
gem 'jquery-turbolinks'
gem 'kaminari'
gem 'rails-settings-cached'
gem 'ransack'
gem 'recaptcha', github: 'ambethia/recaptcha'
gem 'redcarpet'
gem 'sanitize'
gem 'sitemap_generator'
gem 'smtpapi'
gem 'stripe', git: 'https://github.com/stripe/stripe-ruby'
gem 'nokogiri'
gem 'inline_svg'

# Memory Caching for performance
gem 'dalli' 
gem 'mailgun'
# gem 'rack-cors', :require => 'rack/cors'

#For facebook and google, twitter authentication
gem 'omniauth'
gem 'omniauth-facebook' 
gem 'omniauth-google-oauth2'  
gem 'omniauth-twitter'
gem "fb_graph"
gem 'httpclient', '~> 2.6.0.1'
gem "breadcrumbs_on_rails"
gem 'quiet_assets'
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'

group :development do
  gem 'better_errors'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'foreman'
  gem 'dotenv-rails'
  gem 'hub', :require=>nil
  gem 'rails_layout'
end

group :development, :test do
  gem 'byebug'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rubocop'
end

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
  gem 'capistrano-multistage'
  gem 'capistrano-ext'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'database_cleaner'
end

group :test do
  gem 'selenium-webdriver'
  gem 'capybara'
  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', require: false
  gem 'email_spec'
end
