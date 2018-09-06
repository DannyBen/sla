require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

include SLA

RSpec.configure do |config|
  config.before :suite do
    # Prepare the cache object with an appropriate cache dir and
    # cache life. Cache life is 1 second if server is running,
    # otherwise it is set to a year, to allow testing on CI environments
    # where localhost server is not running.
    $cache = WebCache.new dir: 'spec/cache'
    $cache.life = File.exist?('mock.pid') ? 1 : '365d'
  end
end
