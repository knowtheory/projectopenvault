def require_all(dir, pattern=/\.rb$/)
  Dir.open(dir).each do |model|
    require File.join(dir, model) if model =~ pattern
  end  
end

here = File.dirname(__FILE__)
app_root = File.join(here, '..')
require File.join here, 'setup'

require_all File.join(app_root, 'lib')

require File.join(here, '..', 'api')
require File.join(here, '..', 'app')
require File.join(here, '..', 'assets')
