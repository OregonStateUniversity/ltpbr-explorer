source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

gem 'activerecord-postgis-adapter'
gem 'aws-sdk', '~> 2.3.0'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '~> 4.3.1'
gem 'coffee-rails', '~> 4.2'
gem 'devise', '>= 4.7.1'
gem 'figaro'
gem 'gon'
gem 'haml'
gem 'haml-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'paperclip', '~> 5.2.1'
gem 'possessive'
gem 'pg'
gem 'puma', '~> 3.12.6'
gem 'rabl-rails'
gem 'rails', '~> 5.2.6'
gem 'recaptcha', require: 'recaptcha/rails'
gem 'sassc-rails', '~> 2.1.2'
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 4.0.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 3.32.2'
  gem 'webdrivers'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end

group :production do
  gem 'airbrake'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
