source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0.rc2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', :platforms => :ruby

# Use Modernizr for better browser compability
gem 'modernizr-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Use fancybox to zoom images
gem 'fancybox2-rails', '~> 0.2.8'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', require: false

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring', group: :development

# For authentication in USP server
gem 'omniauth-oauth', git: 'https://github.com/monitoria-imeusp/omniauth-oauth.git'

# For delayed tasks
gem 'delayed_job_active_record'

# To run tasks
gem 'daemons'

# To generate pdfs
gem 'wicked_pdf'

# To simplify external http requests
gem 'httparty'

group :test do
  # Easier test writing
  gem "shoulda-matchers", require: false # not requiring is necessary to avoid warnings from minitest 5, with version 2.6 this might get fixed

  # Test coverage
  gem 'simplecov', require: false
end

group :development do
  gem 'capistrano',  '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm', "~>0.1.0"
end

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Test framework
  gem 'rspec-activemodel-mocks'
  gem 'rspec-rails', '>= 3.2.0  '#'>= 2.14.0'

  # Fixtures made easy
  gem 'factory_girl_rails', '~> 4.4.1'

  # JavaScript unit tests
  gem "konacha", "~> 3.2.0"

  # Use mailcatcher in development to fake email sending
  gem 'mailcatcher'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  ruby '2.1.1'
end

# Acceptance tests
group :cucumber do
  gem 'cucumber', '~> 1.3.10'
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'poltergeist', '~> 1.5.0'
  gem 'capybara-webkit'
end

# Use devise for login sessions
gem 'devise'

# Internationalization
gem 'rails-i18n'

# Use mechanize to collect courses codes and names
gem 'mechanize'

# Cancan - for authorization
gem 'cancan'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

