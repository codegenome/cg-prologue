#require "net/http"
#require "net/https"
#require "uri"
#require 'rbconfig'

say "Building Application with Prologue..."

# Some git setup
git :init
run 'rm .gitignore'
create_file '.gitignore' do
<<-FILE
.bundle
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
public/system/**/**/**/*
*.swp
FILE
end

# Apply Gemfile
apply File.expand_path("../lib/gemfile.rb", __FILE__)

# Apply Test Suite
apply File.expand_path("../lib/test_suite.rb", __FILE__)

# Apply db create and migrations
apply File.expand_path("../lib/mysql2_db.rb", __FILE__)

# Add the thin gem
apply File.expand_path("../lib/thin.rb", __FILE__)

# Make initializers
apply File.expand_path("../lib/rack-fiber_pool.rb", __FILE__)

run 'bundle install'

say <<-D




  ########################################################################

  Prologue just added like 6 hours to your life. And it's async too!

  Template Installed :: Rails 3 Async

  Make sure you're using MRI Ruby 1.9

  Next run...
  rails s thin

  ########################################################################
D

