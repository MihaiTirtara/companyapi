require './app'

Rack::MethodOverride

run Sinatra::Application
