require './config/setup'

app = Rack::Builder.new do
  # Rack::Cascade runs requests through a list
  # of Rack Apps and returns the first matching
  # route.
  # 
  # Advault::App handles ONLY routes that end
  # with .html
  # 
  # AdVault::Api handles all other routes
  map('/')       { run Rack::Cascade.new([AdVault::App, AdVault::Api]) }
  map('/admin')  { run AdVault::Admin }
  map('/assets') { run AdVault::Assets }
end

run app
