require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

include SLA

# Fool Colsole to think it is in TTY so that we print say replace: true normally
ENV['TTY'] = 'off'

# When testing, we want clean cache
WebCache.flush

RSpec.configure do |config|
  config.before(:suite) do
    healthcheck = `curl -Ss http://localhost:3000/healthcheck/ 2>/dev/null`
    expect(healthcheck).to eq('ok'), 'Please start the mock server'
  end
end
