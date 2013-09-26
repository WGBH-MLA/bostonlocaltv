source 'http://rubygems.org'

gem 'rails', '3.2.14'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mysql2'


## Needs to be outside :assets otherwise production mode breaks
##Don't need after Rails 3.1
#gem 'sass-rails',   '~> 3.1.4'
gem 'bootstrap-sass'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'execjs'
  gem 'therubyracer'
end

gem 'coffee-rails'
gem 'uglifier'

group :test do
  gem "database_cleaner"
  gem "capybara"
  gem 'launchy'
  gem "factory_girl_rails", "~> 4.0"
  gem 'faker'
  gem "aruba"
end

group :development, :test do
  gem "rspec-rails", "~>2.6.0"
  gem "sqlite3"
  gem "debugger"
  gem "meta_request"
end

gem 'guard-rspec', :group => :development

gem 'jquery-rails', '~>2.2.1'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem "compass"

# blacklight gems pinned to semantic versions; cbeer's recommendations
gem 'blacklight', ">= 4.4.1"
gem 'blacklight_advanced_search'
gem 'blacklight_range_limit'

# FIXME! Blacklight 3.2.1 incompatible w/ kaminari 0.14.0
# see https://github.com/projectblacklight/blacklight/issues/460
# Pin to < 0.14.0 until blacklight is upgraded.
gem 'kaminari'

gem "jettywrapper", ">= 1.0.3"
gem "devise"
gem "progressbar"
gem 'unicode'
gem 'activeadmin'

gem 'rails-footnotes', '>= 3.7', :group => :development
gem "rsolr-footnotes"

