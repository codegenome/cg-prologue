run 'rm Gemfile'
create_file 'Gemfile', "source 'http://rubygems.org'\n"
gem "rails", "3.0.0"
gem "sqlite3-ruby", :require => "sqlite3"
if ENV['PROLOGUE_AUTH']
  gem 'devise', ">= 1.1.2"
end
if ENV['PROLOGUE_ROLES']
  gem 'cancan'
end
gem "hoptoad_notifier"
gem "jammit"
gem "friendly_id", "~> 3.1"
gem "will_paginate", "~> 3.0.pre2"
gem "haml", ">= 3.0.21"
gem "rails3-generators", :group => :development
gem "hpricot", :group => :development
gem "ruby_parser", :group => :development
gem "rspec-rails", "2.0.0.beta.22", :group => [:test, :development]
gem "mocha", :group => [:test]
gem "factory_girl_rails", :group => [:test, :cucumber]
gem "faker", :group => [:test]
gem "autotest", :group => [:test]
gem "autotest-rails", :group => [:test]
gem "thin", :group => [:test, :cucumber, :development]
gem "cucumber", :git => "git://github.com/aslakhellesoy/cucumber.git", :group => [:cucumber]
gem "database_cleaner", :git => "git://github.com/bmabey/database_cleaner.git", :group => [:test, :cucumber]
gem "cucumber-rails", :git => "git://github.com/aslakhellesoy/cucumber-rails.git", :group => [:cucumber]
gem "capybara", "0.3.9", :group => [:cucumber]
gem "launchy", :group => [:cucumber]
gem "timecop", :group => [:test, :cucumber]
gem "pickle", :group => [:test, :cucumber]

run 'bundle install'