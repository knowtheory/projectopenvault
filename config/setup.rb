# encoding: UTF-8
require "rubygems"
require "erb"
require "bundler/setup"
groups = [:default]
groups.push(:development) unless ENV['RACK_ENV'] != 'development'
Bundler.require(*groups)

