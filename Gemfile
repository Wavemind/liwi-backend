source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.1'
gem 'pg'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'amoeba'

# Added
gem 'devise'
gem 'devise_invitable', '~> 1.7.0'
gem 'simple_form'
gem 'cocoon'
gem 'bootstrap', '~> 4.1.3'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-datatables'
gem 'ajax-datatables-rails'
gem 'rubocop-airbnb'
gem 'devise_token_auth'
gem 'rack-cors', require: 'rack/cors'
gem 'momentjs-rails'
gem 'database_cleaner'
gem 'breadcrumbs_on_rails'
gem 'carrierwave', '~> 1.0'
gem 'fog-aws'
gem 'hstore_translate'
gem 'nilify_blanks'
gem 'rails-controller-testing'
gem 'react-rails'
gem 'webpacker', '~> 3'
gem 'rqrcode'
gem 'barby'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development do
  gem 'rspec-rails', '~> 3.8'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
  gem 'seed_dump'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'simplecov', require: false
  gem 'codacy-coverage', require: false
end


group :production do
  gem 'appsignal'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'mini_racer', platforms: :ruby
