source 'https://rubygems.org'

ruby '1.9.3', :engine => 'jruby', :engine_version => '1.7.2'

gem 'rails', '3.2.11'
gem 'rails-api'
gem 'api_smith'
gem 'rocket_pants'
gem 'jruby-openssl'

group :development do
  gem 'activerecord-jdbcsqlite3-adapter'
end

group :production do
  gem 'activerecord-jdbcpostgresql-adapter'
end

gem 'celerity'

gem 'puma'

gem 'newrelic_rpm'
gem 'rocket_pants-rpm'