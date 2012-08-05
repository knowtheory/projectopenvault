# encoding: UTF-8
require "rubygems"
require "erb"
require "bundler/setup"
groups = [:default]
groups.push(:development) unless ENV['RACK_ENV'] != 'development'
Bundler.require(*groups)

def require_all(dir, pattern=/\.rb$/)
  Dir.open(dir).each do |model|
    require File.join(dir, model) if model =~ pattern
  end  
end

here = File.dirname(__FILE__)
app_root = File.join(here, '..')
require_all File.join(app_root, 'lib')

logname = ENV['RACK_ENV'] == 'production' ? "production.log" : "development.log"
log = File.new(File.join("log",logname), "a+")
log.sync = true
$stdout.reopen(log)
$stderr.reopen(log)
