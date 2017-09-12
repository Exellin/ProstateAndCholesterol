source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Use Bootstrap as the HTML, CSS, and JS framework
gem 'bootstrap-sass'
# Use bootstrap-will_paginate to as the pagination solution
gem 'bootstrap-will_paginate'
# Use Devise as the authentication solution
gem 'devise'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Nokogirl to parse html for inline form errors
gem 'nokogiri'
# Use Cocoon for nested dynamic forms
gem 'cocoon'
# Use font-awesome as the icon library
gem 'font-awesome-rails'
# Use chart-js for graphing data
gem 'chart-js-rails'
# Use mement-js for parsing and manipulating dates for chart-js
gem 'momentjs-rails'
# Use city-state for grabbing data for all states and cities in the world
gem 'city-state'
# Use chosen-rails to create filteraable dropdowns
gem 'chosen-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Use capybara for feature testing
  gem 'capybara'
  # Use database_cleaner to ensure a clean database slate for testing
  gem 'database_cleaner'
  # Use faker to generate data for use in factories
  gem 'faker'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # Use factory_girl as the fixtures replacement for testing
  gem 'factory_girl_rails'
  # Use poltergeist as the javascript driver for capybara
  gem 'poltergeist'
  # Use rspec as the testing framework
  gem 'rspec-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Use guard to automatically run tests on file save
  gem 'guard-rspec', require: false
  # Use rubocop for ruby file linting
  gem 'rubocop', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :production do
  gem 'pg'
  gem 'rails_12factor'
end
