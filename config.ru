require './config/setup'

app = Rack::Builder.new do
  map('/assets')  { run AdVault::Assets }
  map('/api')     { run AdVault::API }
  map('/')        { run AdVault::App }
end

run app
