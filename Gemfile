source 'http://rubygems.org'

gem 'rails', '3.1.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mysql2'


## Needs to be outside :assets otherwise production mode breaks
gem 'sass-rails',   '~> 3.1.4'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
#  gem 'sass-rails',   '~> 3.1.4'
  gem 'execjs'
  gem 'therubyracer'
end

gem 'coffee-rails', '~> 3.1.1'
gem 'uglifier', '>= 1.0.3'

group :test do
  gem "database_cleaner"
  gem "capybara"
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

gem "compass", ">= 0.12.alpha.1"

# blacklight gems pinned to semantic versions; cbeer's recommendations
gem 'blacklight', '3.2.1'
gem 'blacklight_advanced_search', '1.2.1'
gem 'blacklight_range_limit', '1.2.0'

# FIXME! Blacklight 3.2.1 incompatible w/ kaminari 0.14.0
# see https://github.com/projectblacklight/blacklight/issues/460
# Pin to < 0.14.0 until blacklight is upgraded.
gem 'kaminari', '~>0.13.0'

gem "jettywrapper", ">= 1.0.3"
gem "devise"
gem "progressbar"

gem 'activeadmin'

gem 'rails-footnotes', '>= 3.7', :group => :development
gem "rsolr-footnotes"

