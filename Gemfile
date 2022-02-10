source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

gem 'activerecord-postgis-adapter'
gem 'active_storage_validations'
gem 'activerecord-postgres_enum'
gem 'aws-sdk', '~> 3'
gem 'bootsnap', '>= 1.9.1', require: false
gem 'bootstrap', '~> 4.6.0'
gem 'chosen-rails', '~> 1.8.7'
gem 'coffee-rails', '~> 4.2.2'
gem 'devise', '>= 4.8'
gem 'ffi-geos'
gem 'figaro'
gem 'gon'
gem 'haml'
gem 'haml-rails'
gem 'jbuilder', '~> 2.10.1'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'kaminari', '~> 1.2.2'
gem 'possessive'
gem 'pg'
gem 'puma', '~> 4.3.10'
gem 'rabl-rails'
gem 'rails', '~> 6.0.4.4'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'sassc-rails', '~> 2.1.2'
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 2.7.2'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 5.0.2'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'web-console', '>= 3.3.1'
end

group :test do
  gem 'capybara', '>= 3.36.0'
  gem 'webdrivers'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end

group :production do
  gem 'airbrake'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

