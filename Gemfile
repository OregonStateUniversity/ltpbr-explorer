source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'activerecord-postgis-adapter'
gem 'active_storage_validations'
gem 'activerecord-postgres_enum'
gem 'aws-sdk', '~> 3.1.0'
gem 'bootsnap', '>= 1.16.0', require: false
gem 'bootstrap', '~> 4.6.0'
gem 'chosen-rails', '~> 1.10.0'
gem 'bootstrap-select-rails'
gem 'chartkick'
gem 'devise', '>= 4.9.3'
gem 'ffi-geos'
gem 'figaro'
gem 'groupdate'
gem 'gon'
gem 'haml-rails'
gem 'importmap-rails', '~> 1.2.1'
gem 'jbuilder', '~> 2.11.5'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'possessive'
gem 'pg'
gem 'puma', '~> 6.3.1'
gem 'rabl-rails'
gem 'rails', '~> 7.1.1'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'sassc-rails', '~> 2.1.2'
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'turbolinks', '~> 5.2.1'
gem 'uglifier', '>= 4.2.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 6.0.3'
end

group :development do
  gem 'listen', '~> 3.8.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.1.0'
  gem 'spring-commands-rspec'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'web-console', '>= 4.2.1'
end

group :test do
  gem 'capybara', '>= 3.39.2'
  gem 'webdrivers'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end

group :production do
  gem 'airbrake'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
