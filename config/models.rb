def require_all(dir, pattern=/\.rb$/)
  Dir.open(dir).each do |model|
    require File.join(dir, model) if model =~ pattern
  end  
end

here = File.dirname(__FILE__)
app_root = File.join(here, '..')
require File.join here, 'setup'

db_config = YAML.load(ERB.new(File.open(File.join(here, 'database.yml' )).read).result)
DataMapper.setup(:default, db_config[ENV['RACK_ENV'] || 'development'])

require_all File.join(app_root, 'models')

DataMapper.finalize
