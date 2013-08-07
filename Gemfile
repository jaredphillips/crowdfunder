source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc2'

# Use postgres as the database for Active Record
gem "pg", "~> 0.15.1"

# Use mime-types to validate if images are being uploaded. 
gem 'mime-types'

# use carrierwave for uploading of images
gem 'carrierwave'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Use kaminari for pagination
gem 'kaminari'
gem 'kaminari-bootstrap'

# To Roman Numerals
gem 'roman-numerals'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# use sorcery for user authentication
gem "sorcery", "~> 0.8.2"

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# group :tools do
#   gem 'guard-test' # automatically runs our tests whenever there have been changes made to them
# end

group :development do
end

group :test do 
  gem "factory_girl_rails" 
  gem "capybara"  # needed for our integration tests, which we'll talk about more later
  gem 'database_cleaner' # used to undo any changes we made to the database during tests
  gem 'capybara-webkit' #capybara driver needed to handle javascript.
  gem "launchy"
  # gem 'letter_opener'
end

# This tutorial requires bootstrap, not us. 
gem "bootstrap-sass", "~> 2.3.2.0"

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
