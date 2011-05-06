run 'rm Gemfile'
create_file 'Gemfile', "source 'http://rubygems.org'\n"
gem "rails" , "~> 3.0.0"
gem "database_cleaner", :group => :test
gem "rspec-rails", "~> 2.0.0", :group => :test
gem "sqlite3-ruby", :require => "sqlite3", :group => [:test, :development]
