# encoding: utf-8
require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

# Add our cucumber rake task
require 'cucumber/rake/task'
desc "Run all cucumber examples"
Cucumber::Rake::Task.new(:cucumber) do |t|
	t.cucumber_opts = "features --format pretty"
end

# Add our rspec rake task
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
RSpec::Core::RakeTask.new(:test)

task :default => :spec

