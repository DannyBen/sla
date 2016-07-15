require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

include SLA

RSpec.configure do |config|
  config.before :suite do
    cache = Cache.instance.cache
    cache.dir = 'spec/cache'
    cache.life = File.exist?('mock.pid') ? 1 : 86400 * 365 # days

    UrlManager.instance.base_url = 'http://localhost:3000/'
  end
end
