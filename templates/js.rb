
get "http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js",  "public/javascripts/jquery.js"
get "http://github.com/rails/jquery-ujs/raw/master/src/rails.js", "public/javascripts/rails.js"
get "http://html5shiv.googlecode.com/svn/trunk/html5.js", "public/javascripts/shiv.js"

inject_into_file 'config/application.rb', :after => "# JavaScript files you want as :defaults (application.js is always included).\n" do
<<-RUBY
    config.action_view.javascript_expansions[:defaults] = %w(jquery rails)
RUBY
end