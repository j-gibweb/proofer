source 'https://rubygems.org'
ruby '2.1.1'
gem 'rails', '3.2.13'

group :production do
	gem 'pg'
	gem 'thread_safe', '0.2.0'
	gem 'rails_12factor'
end

group :assets do
  gem "sass", "~> 3.2.5"
  gem 'sass-rails'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem "paperclip" #, :git => "git://github.com/thoughtbot/paperclip.git"
gem 'rubyzip',  "~> 0.9.9"
gem "aws-ses", "~> 0.5.0"
gem "fog"
gem "devise"
gem "thin"
gem "css_parser", "~> 1.3.5"
gem 'nokogiri'
gem "unf"
gem 'newrelic_rpm'

gem 'aws-sdk'
gem "pony", "~> 1.5.1"
gem "unicorn"
gem "twilio-ruby"

group :development, :test do
  gem 'sqlite3'
  gem 'guard-rspec', require: false
  gem 'rspec-rails', '2.14.1'
  gem 'zeus'
end

gem 'capistrano', '~> 3.1.0'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'capistrano-rails', '~> 1.1.1'
gem 'capistrano-rvm'
