require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

include SLA

# Fool Colsole to think it is in TTY so that we print "resay" normally
ENV['TTY'] = 'off'

# When testing, we want clean cache
WebCache.flush
