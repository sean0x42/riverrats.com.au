# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 3.17'
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
gem 'bcrypt', platform: :ruby
gem 'bootsnap', require: false
gem 'coffee-rails', '~> 4.2'
gem 'connection_pool'
gem 'coveralls', require: false
gem 'devise'
gem 'elasticsearch'
gem 'friendly_id', '~> 5.2.5'
gem 'ice_cube'
gem 'inline_svg'
gem 'jbuilder', '~> 2.8'
gem 'js-routes'
gem 'kaminari'
gem 'local_time'
gem 'paperclip', '~> 6.1.0'
gem 'pg', '~> 1.1'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.2.3'
gem 'rubocop-performance'
gem 'sass-rails', '~> 5.0'
gem 'searchkick'
gem 'sidekiq'
gem 'sprockets', '~> 3.7.2'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'wdm', '>= 0.1.0' if Gem.win_platform?
gem 'webpacker', '~> 4.0'
