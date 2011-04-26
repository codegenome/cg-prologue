# encoding: utf-8
require 'bundler'
Bundler.setup
Bundler::GemHelper.install_tasks

require 'cucumber/rake/task'
# Add our rake task
Cucumber::Rake::Task.new(:cucumber) do |t|
	t.cucumber_opts = "features --format pretty"
end

