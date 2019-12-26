lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date'
require 'sla/version'

Gem::Specification.new do |s|
  s.name        = 'sla'
  s.version     = SLA::VERSION
  s.date        = Date.today.to_s
  s.summary     = "Command Line Site Link Analyzer"
  s.description = "Check for broken links on a website"
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = ["sla"]
  s.homepage    = 'https://github.com/DannyBen/sla'
  s.license     = 'MIT'
  s.required_ruby_version = ">= 2.4.0"

  s.add_dependency 'colsole', '~> 0.7'
  s.add_dependency 'super_docopt', '~> 0.1'
  s.add_dependency 'webcache', '~> 0.4'
  s.add_dependency 'nokogiri', '~> 1.8'
end
