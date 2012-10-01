here = File.dirname(__FILE__)
app_root = File.join(here, '..')
require File.join here, 'setup'

module AdVault
  if ENV['RACK_ENV'] == "production"
    HOSTNAME = "data.projectopenvault.com"
  else
    HOSTNAME = "localhost:9292"
  end
end

require File.join(here, '..', 'api')
require File.join(here, '..', 'app')
require File.join(here, '..', 'assets')
