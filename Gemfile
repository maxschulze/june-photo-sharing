source 'https://rubygems.org'

gem 'rails', '3.2.12'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :production, :staging, :development do
  gem 'mysql2'
  gem 'thin'
end

# Auth
gem 'devise'
gem 'devise_invitable', '~> 1.1.0'
gem 'cancan'

gem 'jquery-rails'
gem 'simple_form'
gem 'carrierwave'
gem 'mini_magick'
gem "fog"

gem 'newrelic_rpm'

gem 'kaminari'
gem 'kaminari-bootstrap'

gem 'exifr'

gem 'capistrano'

# CI
gem 'rake'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass'
end

group :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
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