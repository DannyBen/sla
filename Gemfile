source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'adsf'
gem 'byebug'
gem 'lp'
gem 'rspec'
gem 'rspec_fixtures'
gem 'runfile'
gem 'runfile-tasks'
gem 'simplecov'
gem 'webcache', path: '/vagrant/gems/webcache'

gemspec