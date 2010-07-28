source 'http://rubygems.org'

gem "bundler", "~> 1.0.0.rc.1"
gem 'rails', '3.0.0.rc'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem "ruby-debug"
  gem "wirble"
end

group :production do
  gem "pg"
end

group :test do
  gem "cucumber-rails"
  gem "shoulda"
  gem "factory_girl_rails"
  gem "mocha"
  gem "capybara"
  gem "launchy"
  gem "database_cleaner"
  gem "fakeweb"
  gem "ZenTest"
  gem "autotest-rails"
  gem "redgreen"
end

# gem 'twitter-auth', :require => 'twitter_auth'
gem "twitter-auth", :git => "git://github.com/dpmcnevin/twitter-auth.git", :branch => "rails_3", :require => "twitter_auth/engine"
# gem "twitter-auth", :path => "../twitter-auth", :require => "twitter_auth/engine"
gem 'oauth', ">= 0.3.1"
gem "json"
