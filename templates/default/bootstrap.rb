require "net/http"
require "net/https"
require "uri"
require 'rbconfig'

say "Building Application with Prologue..."

def get_remote_https_file(source, destination)
  uri = URI.parse(source)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  path = File.join(destination_root, destination)
  File.open(path, "w") { |file| file.write(response.body) }
end

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
public/assets/
.idea/*
.sass-cache/**/*
*.swp
FILE
end

create_file '.rvmrc' do
<<-FILE
rvm #{ENV['RUBY_VERSION']}@#{app_name} --create
FILE
end

# Apply Gemfile
apply File.expand_path("../lib/gemfile.rb", __FILE__)

# Apply patch
apply File.expand_path("../lib/patch.rb", __FILE__)

# Apply generators
apply File.expand_path("../lib/generators.rb", __FILE__)

# Apply rails clean up
apply File.expand_path("../lib/rails_clean.rb", __FILE__)

# Apply js
apply File.expand_path("../lib/js.rb", __FILE__)

# Apply css
apply File.expand_path("../lib/css.rb", __FILE__)

# Apply evergreen and jasmin
apply File.expand_path("../lib/evergreen.rb", __FILE__)

# Apply HTML5 Layout
apply File.expand_path("../lib/application_layout.rb", __FILE__)

# Apply SASS
apply File.expand_path("../lib/sass.rb", __FILE__)

# Apply Test Suite
apply File.expand_path("../lib/test_suite.rb", __FILE__)

# Apply Friendly Id
apply File.expand_path("../lib/friendly_id.rb", __FILE__)

# Apply Devise?
apply File.expand_path("../lib/devise.rb", __FILE__) if ENV['PROLOGUE_AUTH']

# Apply admin
apply File.expand_path("../lib/admin.rb", __FILE__) if ENV['PROLOGUE_ADMIN']

# Apply cancan
apply File.expand_path("../lib/cancan.rb", __FILE__) if ENV['PROLOGUE_ROLES']

# Apply db create and migrations
apply File.expand_path("../lib/db.rb", __FILE__)

# Apply db seeds
apply File.expand_path("../lib/db_seed.rb", __FILE__)

# Make a home controller
apply File.expand_path("../lib/home_controller.rb", __FILE__)

# Make initializers
apply File.expand_path("../lib/initializers.rb", __FILE__)

# Clean up generated routes
apply File.expand_path("../lib/clean_routes.rb", __FILE__)

# Setup yard
apply File.expand_path("../lib/yard.rb", __FILE__)

# Remove RSpec stuff we are not gonna use right away
apply File.expand_path("../lib/rspec_clean.rb", __FILE__)

# Make the form errors work like they did in 2.3.8
apply File.expand_path("../lib/dynamic_form.rb", __FILE__)

# Setup Capistrano
apply File.expand_path("../lib/capistrano.rb", __FILE__)

login_msg = (ENV['PROLOGUE_ADMIN']) ? "Login to admin with email #{ENV['PROLOGUE_USER_EMAIL']} and password #{ENV['PROLOGUE_USER_PASSWORD']}" : ""

say <<-D




  ########################################################################

  Prologue just added like 6 hours to your life.

  Template Installed :: Quick Left Rails 3 Prologue Default

  Next run...
  rake spec
  rake cucumber
  rails s

  #{login_msg}

  ########################################################################
D
