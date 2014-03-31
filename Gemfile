source 'https://rubygems.org'

gem 'rails', '3.2.13'

group :production do
	gem 'pg'
	gem 'thread_safe', '0.2.0'
end

# Gems used only for assets and not required
# in production environments by default.

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem "paperclip" , :git => "git://github.com/thoughtbot/paperclip.git"
gem 'rubyzip',  "~> 0.9.9"
gem "aws-ses", "~> 0.5.0"
gem "fog"
gem "devise"
gem "thin"
gem "css_parser", "~> 1.3.5"
gem 'nokogiri'
gem "unf"
gem 'newrelic_rpm'
gem 'rails_12factor', group: :production

gem "ruby-xslt"
gem 'aws-sdk'
gem "pony", "~> 1.5.1"

group :development, :test do
	gem 'sqlite3'
	# gem 'pg'
  gem 'guard-rspec', require: false
  gem 'rspec-rails', '2.14.1'
  gem 'zeus'
end

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
