# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# BASE =========================================================================
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'

# Use Puma as the app server
gem 'puma', '~> 3.11'

# MODEL ========================================================================
# User auth
# rails g devise:install
gem 'devise', '>= 4.6.0'
# create config/initializers/omniauth.rb
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
# admin
# rails g pundit:install
gem 'pundit'
# manage
gem 'administrate'

# VIEW =========================================================================
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Use SCSS for stylesheets
# gem 'sass-rails', '~> 5'

# decorator (presentation layer)
gem 'draper'
# pager
# rails g kaminari:config
gem 'kaminari'
# serializer
gem 'fast_jsonapi'

# SEO
gem 'meta-tags'
gem 'sitemap_generator'

# DB ===========================================================================
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'

# Use Redis adapter to run Action Cable in production
# Install redis to your computer
# create redis setting
gem 'redis', '~> 4.0'
gem 'redis-rails'

# OTHERS =======================================================================
# Use Capistrano for deployment
gem 'capistrano-rails', group: :development
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'

# Turbolinks makes navigating your web application faster.
# Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'

# Use Active Storage variant
gem 'image_processing', '~> 1.4'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution
  # and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # Spring speeds up development by keeping your application
  # running in the background. Read more: https://github.com/rails/spring
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Rspec test
  gem 'factory_bot_rails'
  gem 'faker'
  # pry
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'pry-remote'
  # Rspec
  # rails g rspec:install
  gem 'email_spec'
  gem 'rspec'
  gem 'rspec-rails'
  # speed up test
  gem 'guard', '>= 2.2.2', require: false
  gem 'guard-livereload', require: false
  gem 'guard-rspec', require: false
  gem 'rack-livereload'
end

group :development do
  # dummy email
  gem 'letter_opener'
  # rubocop
  gem 'rubocop'
  # Access an interactive console on exception pages
  # or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
