# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# 3.7.1 has a security vulnerability.
gem 'sprockets', '~> 3.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.9'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', platform: :ruby

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 3.20'
  gem 'selenium-webdriver'
end

group :development do
  gem 'capistrano', '~> 3.11.0', require: false
  gem 'capistrano-bundler', '~> 1.5', require: false
  gem 'capistrano-passenger', require: false
  gem 'capistrano-rails', '~> 1.3', require: false
  gem 'capistrano-rvm', require: false
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', require: false
  gem 'scss_lint', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :production do
  gem 'unicorn', platform: :ruby
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'autoprefixer-rails'
gem 'bootsnap', require: false
gem 'connection_pool'
gem 'coveralls', require: false
gem 'devise'
gem 'elasticsearch'
gem 'friendly_id', '~> 5.2.5'
gem 'ice_cube'
gem 'js-routes'
gem 'kaminari'
gem 'local_time'
gem 'paperclip', '~> 6.1.0'
gem 'searchkick'
gem 'sidekiq'
gem 'wdm', '>= 0.1.0' if Gem.win_platform?
gem 'webpacker', '~> 4.0'
