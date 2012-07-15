require './config/setup'

app = Rack::Builder.new do
  map('/assets')  { run AdVault::Assets }
  map('/spending'){ run AdVault::Spending }
  map('/ads')     { run AdVault::Ads }
  map('/')        { run AdVault::App }
  map('/admin')   { run AdVault::Admin }
end

run app
