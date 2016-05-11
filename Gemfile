source 'http://rubygems.org'

gem 'rails', '~> 3.2.16'
gem 'syck', platforms: [:ruby_20]

gem 'activeadmin'
gem 'blacklight', '~>4.6.3'
gem 'blacklight_advanced_search'
gem 'blacklight_range_limit'
gem 'bootstrap-sass'
gem 'carrierwave'

# Need to pin sass to < 3.3 b/c of incompatibility with compass 0.12.
# The other options was to bump compass up to 0.13.alpha, but that was triggering more dependency issues.
# see https://github.com/chriseppstein/compass/issues/1339
gem 'sass', '~> 3.2.13'

gem 'coffee-rails'
gem 'compass'
gem 'devise'
gem 'jquery-rails', '~> 3.1.3'
gem 'jquery-ui-rails'
gem 'kaminari'
gem 'sqlite3'
gem 'progressbar'
# gem 'rsolr-footnotes'
gem 'therubyracer'
gem 'uglifier'
gem 'unicode'
gem 'state_machine'
gem 'blacklight_oai_provider', git: "https://github.com/cbeer/blacklight_oai_provider.git"
gem 'dotenv-rails', '0.8.0'
gem 'cmless', '1.0.0'

group :test do
  gem 'aruba'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'faker'
  gem 'launchy'
end

group :development, :test do
  # gem 'debugger'
  # gem 'guard-rspec'
  gem 'jettywrapper'
  gem 'meta_request'
  gem 'rails-footnotes', '>= 3.7'
  gem 'rspec-rails', '~> 2.99.0'
  gem 'net-ssh', '~> 2.7.0'
end

group :development do 
  gem 'capistrano', '~> 2', :require => false # Cap 3 doesn't yet have all the kinks worked out
  gem 'capistrano-multistage', :require => false
  gem 'capistrano-gitflow', :require => false
end
