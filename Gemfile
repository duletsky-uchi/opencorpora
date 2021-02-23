source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'pry', '~> 0.13.1'
  gem 'pry-byebug', '~> 3.9.0'

  gem 'bundler-audit', '~> 0.7.0'

  gem 'rubocop', '~> 1.00.0', require: false
  gem 'awesome_print'
  gem 'bunny-mock'
  gem 'colorize'

  gem 'fasterer'
  gem 'json-schema'
  gem 'json_matchers', '0.7.0'
  gem 'rspec-its'
  gem 'rspec-json_expectations' # частичное сопоставление include_json
  #gem 'rspec-rails'
  gem 'rspec-rails', git: 'https://github.com/rspec/rspec-rails', branch: '4-0-maintenance'
  gem 'rubocop-rspec'
  # gem 'selenium-webdriver'

  gem 'rubycritic', '~> 4.5'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'guard', '~> 2.16.2' # автозапуск тестов
  gem 'guard-bundler'
  gem 'guard-rails', require: false
  gem 'guard-rspec', require: false
  gem 'simplecov', require: false # отчет по покрытию тестами

  gem 'ruby_jard' # отладчик

  gem 'factory_bot_rails'# в проде Sessions засеваются им
  gem 'ffaker'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'

  gem 'webmock' # для моканья запросов к урлам
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'pg', '~> 1.0'
gem 'activerecord-import' # batch insert
