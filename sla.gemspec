lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sla/version'

Gem::Specification.new do |s|
  s.name        = 'sla'
  s.version     = SLA::VERSION
  s.date        = Date.today.to_s
  s.summary     = "Site Link Analyzer"
  s.description = "Check for broken links on a website"
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = ["sla"]
  s.homepage    = 'https://github.com/DannyBen/sla'
  s.license     = 'MIT'
  s.required_ruby_version = ">= 2.2.2"

  s.add_dependency 'colsole', '~> 0.4'
  s.add_dependency 'docopt', '~> 0.5'
  s.add_dependency 'webcache', '~> 0.2'
  s.add_dependency 'nokogiri', '~> 1.6'

  s.add_development_dependency 'runfile', '~> 0.8'
  s.add_development_dependency 'adsf', '~> 1.2'
  s.add_development_dependency 'runfile-tasks', '~> 0.4'
  s.add_development_dependency 'byebug', '~> 9.0'
  s.add_development_dependency 'rspec', '~> 3.4'
  s.add_development_dependency 'simplecov', '~> 0.11'
end
