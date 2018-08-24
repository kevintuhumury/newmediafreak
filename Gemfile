source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.1'
gem 'pg'
gem 'puma'

gem 'kuva', '0.1.2'

gem 'friendly_id', '~> 5.1.0'
gem 'newrelic_rpm'
gem 'xml-sitemap'

gem 'haml'
gem 'sass-rails'
gem 'compass-rails'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'uglifier'
gem 'turbolinks'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'rspec-rails'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'fabrication'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
  gem 'capybara'
  gem 'simplecov', require: false
end
