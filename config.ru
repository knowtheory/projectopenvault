require './config/setup'
require './config/models'
require './config/app'

logname = ENV['RACK_ENV'] == 'production' ? "production.log" : "development.log"
log = File.new(File.join("log",logname), "a+")
log.sync = true
$stdout.reopen(log)
$stderr.reopen(log)

# Rack is a web server API for Ruby.
# Rack apps accept requests, and respond with an array of three things:
# A status, headers and the body.
# 
# Read more about it here: http://rack.rubyforge.org/doc/SPEC.html
# 
# Rack::Builder is a little wrapper that fits around other Rack apps
# to coordinate their behavior.
app = Rack::Builder.new do
  Garner::Cache::ObjectIdentity::KEY_STRATEGIES = [
    Garner::Strategies::Keys::RequestGet,
    Garner::Strategies::Keys::Jsonp
  ]
  map('/assets') { run AdVault::Assets }

  # Rack::Cascade runs requests through a list
  # of Rack Apps and returns the first matching
  # route.
  # 
  # Advault::App is a Sinatra app handles ONLY routes that end with .html
  # AdVault::Api is a Grape app handles all other routes
  map('/') do
    run Rack::Cascade.new([AdVault::App, AdVault::Api])
  end

  map('/admin')  { run AdVault::Admin }
end

use Rack::JSONP
use Rack::ETag
use Rack::Cache,
  :verbose     => true,
  :metastore   => 'file:tmp/meta',
  :entitystore => 'file:tmp/body'

run app
