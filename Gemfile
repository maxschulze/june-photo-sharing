source 'https://rubygems.org'

gem 'rails', '~> 4.0'
gem 'protected_attributes'
gem 'mysql2'

# Use SCSS for stylesheets
gem "less-rails", "~> 2.4.2"
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Auth
gem 'devise',           '>= 3.0.0'
gem 'devise_invitable', '~> 1.2.1'
gem 'cancan'

gem 'simple_form', '~> 3.0.0', github: 'plataformatec/simple_form', branch: 'master'
gem 'carrierwave', '~> 0.10.0'
gem 'mini_magick'

gem 'newrelic_rpm'

gem 'kaminari'
gem 'kaminari-bootstrap'

gem 'capistrano', "~> 2.15.5"

# E-Mail Processing
gem 'mandrill-rails'

# CI
gem 'rake'

gem 'friendly_id', '~> 5.0.0'

group :test do
  gem 'sqlite3'
  gem 'webmock'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'cucumber'
  gem 'cucumber-rails', :require => false
  gem 'launchy'
  gem 'guard'
  gem 'guard-cucumber'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'guard-migrate'
  gem 'growl'
  gem 'pry'
  gem 'email_spec'
  gem 'shoulda-matchers'
  gem 'poltergeist'
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'resque_spec'
  gem 'capybara'
end

group :development do
  gem 'quiet_assets'
end