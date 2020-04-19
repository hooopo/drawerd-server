# frozen_string_literal: true

source "https://gems.ruby-china.com"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "dotenv-rails", "~> 2.7", require: "dotenv/rails-now"
gem "rails", "~> 5.2.2"

# Use Puma as the app server
gem "puma", "~> 3.12"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.1.0", require: false
gem "jquery-rails"
gem "cocoon"

group :development, :test do
  gem "annotate"
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-performance", require: false
  gem "capistrano", "~> 3.8.2"
  gem "capistrano-rvm"
  gem "capistrano-rails", "~> 1.1.0"
  gem "capistrano3-puma"
  gem "capistrano-yarn", require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem "chromedriver-helper"
end

# ADD TRANSPILER TO USE ES6
gem "sprockets"
gem "sprockets-es6"

gem "pg"

gem "ruby-graphviz", "~> 1.2", require: "graphviz"

gem "pry-rails", "~> 0.3.9"

gem "shrine", "~> 3.2"

gem "dry-struct", "~> 1.3"

gem "sentry-raven", "~> 3.0"

gem "sendgrid-actionmailer", "~> 3.0"

gem "bcrypt", "~> 3.1"
