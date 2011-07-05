run 'rm public/index.html'
run 'rm README'
run 'rm public/favicon.ico'
get "http://www.quickleft.com/favicon.ico", "public/favicon.ico"
# get "http://www.quickleft.com/ati.png", "public/images/ati.png"
create_file 'README.md' do
<<-FILE
#{app_name.humanize}
===========
FILE
end
