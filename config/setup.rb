# encoding: UTF-8
require "rubygems"
require "erb"
require "bundler/setup"
groups = [:default]
groups.push(:development) unless ENV['RACK_ENV'] != 'development'
Bundler.require(*groups)

here = File.dirname(__FILE__)
app_root = File.join(here, '..')
db_config = YAML.load(ERB.new(File.open(File.join(here, 'database.yml' )).read).result)
DataMapper.setup(:default, db_config[ENV['RACK_ENV'] || 'development'])

def require_all(dir, pattern=/\.rb$/)
  Dir.open(dir).each do |model|
    require File.join(dir, model) if model =~ pattern
  end  
end

require_all File.join(app_root, 'lib')
require_all File.join(app_root, 'models')

DataMapper.finalize

require File.join(here, '../api')
require File.join(here, '../app')
require File.join(here, '../assets')

