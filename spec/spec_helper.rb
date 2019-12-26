require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

include SLA

# Enable Colsole colors in testing mode
ENV['TTY'] = 'on'

# When testing, we want clean cache
WebCache.flush
