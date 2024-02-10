lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sla/version'

Gem::Specification.new do |s|
  s.name        = 'sla'
  s.version     = SLA::VERSION
  s.summary     = 'Command Line Site Link Analyzer'
  s.description = 'Check for broken links on a website'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.executables = ['sla']
  s.homepage    = 'https://github.com/DannyBen/sla'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 3.1.0'

  s.add_dependency 'colsole', '>= 0.8.1', '< 2'
  s.add_dependency 'mister_bin', '~> 0.7'
  s.add_dependency 'nokogiri', '~> 1.10'
  s.add_dependency 'webcache', '~> 0.8'

  s.metadata['rubygems_mfa_required'] = 'true'
end
