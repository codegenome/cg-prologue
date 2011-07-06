create_file 'Gemfile', "source 'http://rubygems.org'\n"

gem 'rails', "~> #{ENV['PROLOGUE_RAILS_VERSION']}"

gem 'sqlite3-ruby', :require => 'sqlite3'
if ENV['PROLOGUE_AUTH']
  gem 'devise', '~> 1.4.2'
end
if ENV['PROLOGUE_ROLES']
  gem 'cancan'
end
gem 'hoptoad_notifier'
gem 'friendly_id', '~> 3.3.0.alpha2'
gem 'will_paginate', '~> 3.0.pre2'
gem 'yard'
gem 'bluecloth'

gem 'coffee-script'
gem 'haml-rails'
gem 'jquery-rails'
gem 'sass-rails', '~> 3.1.0.rc.2'
gem 'uglifier'

gem 'rails3-generators' , :group => :development
gem 'hpricot'           , :group => :development
gem 'ruby_parser'       , :group => :development

gem 'mocha'          , :group => :test
gem 'faker'          , :group => :test
gem 'autotest'       , :group => :test
gem 'autotest-rails' , :group => :test

gem 'cucumber'             , :group => :cucumber
gem 'cucumber-rails'       , :group => :cucumber
gem 'capybara', '~> 1.0.0' , :group => :cucumber
gem 'launchy'              , :group => :cucumber

gem 'rspec-rails', '~> 2.6.1'                  , :group => [:test, :development]
gem 'evergreen', :require => 'evergreen/rails' , :group => [:test, :development]

gem 'factory_girl_rails' , :group => [:test, :cucumber]
gem 'database_cleaner'   , :group => [:test, :cucumber]
gem 'timecop'            , :group => [:test, :cucumber]
gem 'pickle'             , :group => [:test, :cucumber]

gem 'thin', :group => [:test, :cucumber, :development]

# for windows users
if ( (Config::CONFIG['host_os'] =~ /mswin|mingw/) && (Config::CONFIG["ruby_version"] =~ /1.8/) )
  gem 'win32console', :group => [:test, :cucumber]
  gem 'windows-pr', :group => [:test, :cucumber]
  gem 'win32-open3'
end

run 'bundle install'
