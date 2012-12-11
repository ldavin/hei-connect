# Gems
require "rubygems"
require "bundler/setup"
require 'goliath'
require 'grape'
require 'celerity'
require 'active_support/core_ext/time/calculations'

# Konosys
Dir["app/konosys/*.rb"].each { |file| require file }
Dir["app/konosys/models/*.rb"].each { |file| require file }
Dir["app/konosys/exceptions/*.rb"].each { |file| require file }
Dir["app/konosys/actions/*.rb"].each { |file| require file }

# API
Dir["app/api/api_v*.rb"].each { |file| require file }
require "app/api/api"

class Application < Goliath::API

  def response(env)
    API::API.call(env)
  end

end