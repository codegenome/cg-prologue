generate(:controller, "home index")

create_file 'app/views/home/index.html.haml' do
<<-FILE
%h1 #{app_name.humanize}
FILE
end

inject_into_file 'config/routes.rb', :after => "# root :to => \"welcome#index\"\n" do
<<-RUBY
  root :to => "home#index"
RUBY
end