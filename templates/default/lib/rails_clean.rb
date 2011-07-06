run 'rm public/index.html'
run 'rm app/assets/images/rails.png'
run 'rm app/assets/stylesheets/application.css'
run 'rm README'
run 'rm public/favicon.ico'
create_file 'README.md' do
<<-FILE
#{app_name.humanize}
===========
FILE
end
