require './config/setup'

run Rack::Builder.new do
  map('/api') { run AdVault::API }
  map('/')    { run AdVault::App }
end
