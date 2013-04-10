# This file is used by Rack-based servers to start the application.

# Disable log buffering for Heroku
$stdout.sync = true

require ::File.expand_path('../config/environment',  __FILE__)
run HeiConnect::Application
