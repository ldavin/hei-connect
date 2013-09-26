Airbrake.configure do |config|
  config.api_key = ENV['ERRBIT_API_KEY']
  config.host    = 'hei-connect-error.herokuapp.com'
  config.port    = 443
  config.secure  = config.port == 443
end