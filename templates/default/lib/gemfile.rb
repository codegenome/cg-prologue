run 'rm Gemfile'
create_file 'Gemfile', "source 'http://rubygems.org'\n"
gem "rails", "~> 3.1.0.rc4"
gem "sqlite3-ruby", :require => "sqlite3"
if ENV['PROLOGUE_AUTH']
  gem 'devise', "~> 1.4.2"
end
if ENV['PROLOGUE_ROLES']
  gem 'cancan'
end
gem "hoptoad_notifier"
gem "jammit"
gem "friendly_id", "~> 3.2.1.1"
gem "will_paginate", "~> 3.0.pre2"
gem "haml", "~> 3.1.2"
gem "haml-rails"
gem "yard"
gem "bluecloth"
gem "rails3-generators", :group => :development
gem "hpricot", :group => :development
gem "ruby_parser", :group => :development
gem "rspec-rails", "~> 2.6.1", :group => [:test, :development]
gem "mocha", :group => [:test]
gem "factory_girl_rails", :group => [:test, :cucumber]
gem "faker", :group => [:test]
gem "autotest", :group => [:test]
gem "autotest-rails", :group => [:test]
gem "thin", :group => [:test, :cucumber, :development]
gem "cucumber", :group => [:cucumber]
gem "database_cleaner", :group => [:test, :cucumber]
gem "cucumber-rails", :group => [:cucumber]
gem "capybara", "~> 1.0.0", :group => [:cucumber]
gem "launchy", :group => [:cucumber]
gem "timecop", :group => [:test, :cucumber]
gem "pickle", :group => [:test, :cucumber]
gem "evergreen", :require => "evergreen/rails", :group => [:test, :development]

# for windows users
if ( (Config::CONFIG['host_os'] =~ /mswin|mingw/) && (Config::CONFIG["ruby_version"] =~ /1.8/) )
  gem "win32console", :group => [:test, :cucumber]
  gem "windows-pr", :group => [:test, :cucumber]
  gem "win32-open3"
end
run 'bundle install'
