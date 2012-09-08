require 'rake'

namespace :server do
  task :stop do
    `kill \`cat tmp/rack.pid\``
  end

  task :start do
    `bundle exec rackup -D -P tmp/rack.pid`
  end

  task :restart => [:stop, :start]
end

namespace :data do
  task :import do
    load './data/import.rb'
  end
end


task :console do
  require 'irb'
  ARGV.clear
  require './config/models'
  IRB.start
end