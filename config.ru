require './config/setup'

app = Rack::Builder.new do
  map('/assets')  { run AdVault::Assets }
  map('/spending'){ run AdVault::Spending }
  map('/ads')     { run Advault::Ads }
  map('/')        { run AdVault::App }
  map('/admin')   { run Advault::Admin }
end

run app
