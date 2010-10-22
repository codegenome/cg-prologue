say "Building admin"
generate(:controller, "admin/dashboard index")

inject_into_file 'config/routes.rb', :after => "devise_for :users\n" do
<<-RUBY
  match 'admin' => 'admin/dashboard#index'
RUBY
end

# Do layout and SASS stuff
apply File.expand_path("../admin/sass.rb", __FILE__)
apply File.expand_path("../admin/layout.rb", __FILE__)

create_file 'app/controllers/admin/base_controller.rb' do
<<-RUBY
class Admin::BaseController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!  
end
RUBY
end

gsub_file 'app/controllers/admin/dashboard_controller.rb', /ApplicationController/, 'Admin::BaseController'

# make a user admin
apply File.expand_path("../admin/users.rb", __FILE__)
apply File.expand_path("../admin/dashboard_spec.rb", __FILE__)
apply File.expand_path("../admin/users_spec.rb", __FILE__)
apply File.expand_path("../admin/cucumber.rb", __FILE__)