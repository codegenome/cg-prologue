create_file 'Gemfile' do

  gemfile = <<-RUBY

source 'http://rubygems.org'

# Core

gem 'rails' , '~> #{ENV['PROLOGUE_RAILS_VERSION']}'
gem 'rake'  , '~> 0.9.2'

# Database

# Miscellaneous

gem 'bluecloth'                         # Markdown
RUBY

  if ENV['PROLOGUE_ROLES']
    gemfile << "gem 'cancan'                            # authorization\n"
  end

  if ENV['PROLOGUE_AUTH']
    gemfile << "gem 'devise'        , '~> 1.4.2'        # authentication\n"
  end

  gemfile << <<-RUBY
gem 'friendly_id'   , '~> 3.3.0.alpha2' # slugging and permalink
gem 'hpricot'                           # HTML parser
gem 'rails_config'                      # settings
gem 'will_paginate' , '~> 3.0.pre2'     # pagination
gem 'formtastic'                        # form builder

# Asset pipeline

gem 'coffee-script'
gem 'haml-rails'
gem 'jquery-rails'
gem 'sass-rails', '~> 3.1.0.rc.2'
gem 'uglifier'

# External services

gem 'hoptoad_notifier'

# Groups

group :development do
  gem 'annotate'
  gem 'rails3-generators' # a bunch of generators
  gem 'ruby_parser'
  gem 'yard'              # documentation generation
end

group :test do
  gem 'autotest'
  gem 'autotest-rails'
  gem 'faker'           # fake data generator
  gem 'mocha'           # mocking and stubbing
end

group :cucumber do
  gem 'capybara', '~> 1.0.0'
  gem 'cucumber'
  gem 'cucumber-rails'
  gem 'launchy'
end

group :development, :test do
  gem 'evergreen'    , :require => 'evergreen/rails'
  gem 'rspec-rails'  , '~> 2.6.1'
  gem 'sqlite3-ruby' , :require => 'sqlite3'
end

group :cucumber, :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'pickle'
  gem 'timecop'
end

group :cucumber, :development, :test do
  gem 'thin'
end
RUBY

  # for windows users
  if ( (Config::CONFIG['host_os'] =~ /mswin|mingw/) && (Config::CONFIG["ruby_version"] =~ /1.8/) )
    gemfile << <<-RUBY
gem 'win32console', :group => [:test, :cucumber]
gem 'windows-pr', :group => [:test, :cucumber]
gem 'win32-open3'
RUBY
  end

  gemfile

end

run 'bundle install'
