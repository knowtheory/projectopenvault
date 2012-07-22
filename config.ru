require './config/setup'

# Rack is a web server API for Ruby.
# Rack apps accept requests, and respond with an array of three things:
# A status, headers and the body.
# 
# Read more about it here: http://rack.rubyforge.org/doc/SPEC.html
# 
# Rack::Builder is a little wrapper that fits around other Rack apps
# to coordinate their behavior.
app = Rack::Builder.new do
  # Rack::Cascade runs requests through a list
  # of Rack Apps and returns the first matching
  # route.
  # 
  # Advault::App is a Sinatra app handles ONLY routes that end with .html
  # AdVault::Api is a Grape app handles all other routes
  map('/')       { run Rack::Cascade.new([AdVault::App, AdVault::Api]) }
  map('/admin')  { run AdVault::Admin }
  map('/assets') { run AdVault::Assets }
end

run app
