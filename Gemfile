source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby file: '.ruby-version'

gem 'activerecord-postgis-adapter', '~> 9.0.1'
gem 'active_storage_validations', '~> 1.1.4'
gem 'activerecord-postgres_enum', '~> 2.0.1'
gem 'aws-sdk-s3', '~> 1.146.0', require: false
gem 'bootsnap', '>= 1.18.3', require: false
gem 'bootstrap', '~> 4.6.2'
gem 'chosen-rails', '~> 1.10.0'
gem 'bootstrap-select-rails', '~> 1.13.8'
gem 'chartkick', '~> 5.0.6'
gem 'devise', '>= 4.9.3'
gem 'ffi-geos', '~> 2.4.0'
gem 'figaro', '~> 1.2.0'
gem 'groupdate', '~> 6.4.0'
gem 'gon', '~> 6.4.0'
gem 'haml-rails', '~> 2.1.0'
gem 'importmap-rails', '~> 2.0.1'
gem 'jbuilder', '~> 2.11.5'
gem 'jquery-rails', '~> 4.6.0'
gem 'jquery-turbolinks', '~> 2.1.0'
gem 'pagy', '~> 8.0.1'
gem 'possessive', '~> 1.0.1'
gem 'pg', '~> 1.5.6'
gem 'puma', '~> 6.4.2'
gem 'rabl-rails', '~> 0.6.2'
gem 'rails', '~> 7.1.3.2'
gem 'recaptcha', '~> 5.16.0', require: 'recaptcha/rails'
gem 'sassc-rails', '~> 2.1.2'
gem 'sprockets-rails', '~> 3.4.2', require: 'sprockets/railtie'
gem 'turbolinks', '~> 5.2.1'
gem 'uglifier', '>= 4.2.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 6.1.2'
end

group :development do
  gem 'listen', '~> 3.9.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.1.0'
  gem 'spring-commands-rspec'
  gem 'guard', require: false
  gem 'guard-rspec', require: false
  gem 'web-console', '>= 4.2.1'
end

group :test do
  gem 'capybara', '>= 3.40.0'
  gem 'webdrivers'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end

group :production do
  gem 'airbrake'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
