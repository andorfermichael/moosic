source 'https://rubygems.org'

# Set Ruby version
# ruby '2.2.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Authentificate with different providers like Facebook, Twitter...
gem 'omniauth-oauth2', '~> 1.1.2'
gem 'omniauth-twitter', '~> 1.2', '>= 1.2.1'
gem 'omniauth-facebook', '~> 1.6'
gem 'omniauth-google-oauth2', '~> 0.2.8'
gem 'omniauth-soundcloud', '~> 1.0', '>= 1.0.1'

# Ensure net/https uses OpenSSL::SSL::VERIFY_PEER to verify SSL certificates
# and provides certificate bundle in case OpenSSL cannot find one
gem 'certified', '~> 1.0'

# View helper for gravatar import
gem 'gravatar_image_tag', '~> 1.2'

# Provides bootstrap 3 with SASS for Rails
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.6'

# Social buttons for bootstrap
gem 'bootstrap-social-rails', '~> 4.8'

# Flash Messages with Bootstrap classes and yml
gem 'bootstrap_flash_messages', '~> 1.0', '>= 1.0.2'

# Fontawesome for rails
gem 'font-awesome-rails', '~> 4.5'

# Parse CSS and add vendor prefixes to CSS rules using values from the Can I Use website.
gem 'autoprefixer-rails', '~> 6.1', '>= 6.1.2'

# Enables Client Side Validations
gem 'html5_validators', '~> 1.3'

# Validate e-mail addresses against RFC 2822 and RFC 3696.
gem 'validates_email_format_of', '~> 1.6', '>= 1.6.3'

# If you need to send some data to your js files and you don't want to do this with long way trough views and parsing
gem 'gon', '~> 6.0', '>= 6.0.1'

# ECMAScript2015
gem 'sprockets', '>= 3.0.0'
gem 'sprockets-es6', require: 'sprockets/es6'

# Simple, Heroku-friendly Rails app configuration using ENV and a single YAML file
gem 'figaro', '~> 1.1', '>= 1.1.1'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Rspec-rails is a testing framework for Rails 3.x and 4.x.
  gem 'rspec-rails', '2.13.1'

  # Provides integration between factory_girl and rails
  # factory_girl is a library for setting up Ruby objects as test data
  gem 'factory_girl_rails', '~> 4.5'
end

group :test do
  # Is unit testing framework for Ruby, based on xUnit principles
  gem 'test-unit', '~> 3.1', '>= 3.1.5'

  # Strategies for cleaning databases. Can be used to ensure a clean state for testing
  gem 'database_cleaner', '~> 1.5', '>= 1.5.1'

  # Capybara is an integration testing tool for rack based web applications,
  # it simulates how a user would interact with a website
  gem 'capybara', '~> 2.5'

  # Shoulda Matchers provides RSpec- and Minitest-compatible one-liners that test common Rails functionality,
  # these tests would otherwise be much longer, more complex, and error-prone
  gem 'shoulda-matchers', '~> 3.0', '>= 3.0.1', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Provide livereload
  gem 'guard-livereload', require: false

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'

  # Automatic Ruby code style checking tool.
  # Aims to enforce the community-driven Ruby Style Guide
  gem 'rubocop', '~> 0.36.0'

  # a code metric tool for rails codes, written in Ruby
  gem 'rails_best_practices', '~> 1.15', '>= 1.15.7'

  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
