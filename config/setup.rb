# encoding: UTF-8
require "rubygems"
require "erb"
require "bundler/setup"
groups = [:default]
groups.push(:development) unless ENV['RACK_ENV'] != 'development'
Bundler.require(*groups)
require "sinatra/reloader"

here = File.dirname(__FILE__)
db_config = YAML.load(ERB.new(File.open(File.join(here, 'database.yml' )).read).result)
DataMapper.setup(:default, db_config[ENV['RACK_ENV'] || 'development'])

model_dir = File.join(here, '..', 'models')
Dir.open(model_dir).each do |model|
  require File.join(model_dir, model) if model =~ /\.rb$/
end

DataMapper.finalize

require File.join(here, '../api')
require File.join(here, '../app')
require File.join(here, '../assets')

