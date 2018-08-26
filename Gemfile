source 'https://rubygems.org'

ruby '2.5.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'activerecord-postgis-adapter'
gem 'aws-sdk', '~> 2.3.0'
gem 'bootstrap', '~> 4.0.0.beta3'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'figaro'
gem 'gon'
gem 'haml'
gem 'haml-rails'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'paperclip', "~> 5.2.1"
gem 'possessive'
gem 'pg', '0.20.0'
gem 'puma', '~> 3.7'
gem 'rabl-rails'
gem 'rails', '~> 5.1.5'
gem "recaptcha", require: "recaptcha/rails"
gem 'sass-rails', '~> 5.0'
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.7.0'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'guard'
  gem 'guard-rspec'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
