source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 3.0.4'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'pry'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'twitter'

gem 'httparty'
gem "smart_listing"
gem "jquery-rails"
gem 'haml', '~> 5.0', '>= 5.0.1'
gem 'font-awesome-rails', '~> 4.5'
gem 'paperclip'
gem 'aws-sdk-s3'
gem 'devise'
gem 'active_model_serializers'
gem 'rack-attack'
gem 'webpacker','~> 5.0'
gem 'react_on_rails', '11.2.1' 
gem 'kaminari' 
gem 'api-pagination'
gem "mini_magick"
gem 'rearmed'
gem 'google-cloud-vision'
gem 'rubyzip'
gem 'acts-as-taggable-on', '~> 6.0'
gem 'image_processing'
gem 'sidekiq'
gem 'newrelic_rpm'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  # gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'factory_bot'
  gem "factory_bot_rails", "~> 4.0"
  gem 'rspec'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'database_cleaner'
  gem 'dotenv-rails'
  gem 'timecop'
end

group :test do
  gem 'shoulda', '4.0.0.rc2'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'rspec_junit_formatter', '~> 0.2.3'
  gem "bigdecimal", "1.3.5"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'rails_12factor', group: :production

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'mini_racer', platforms: :ruby