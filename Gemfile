source 'http://rubygems.org'

gem 'rails', '3.0.0.beta4'

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
  gem "webrat"
  gem "fakeweb"
  gem "redgreen"
end

# gem 'twitter-auth', :require => 'twitter_auth'
gem "twitter-auth", :git => "git://github.com/dpmcnevin/twitter-auth.git", :branch => "rails_3", :require => "twitter_auth/engine"
# gem "twitter-auth", :path => "../twitter-auth", :require => "twitter_auth/engine"
gem 'oauth', ">= 0.3.1"
gem 'haml', "3.0.9"
gem "json"
