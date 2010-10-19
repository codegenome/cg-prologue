run 'rm public/index.html'
run 'rm public/images/rails.png'
run 'rm README'
run 'touch README'
run 'rm public/favicon.ico'
get "http://www.quickleft.com/favicon.ico", "public/images/favicon.ico"
# get "http://www.quickleft.com/ati.png", "public/images/ati.png"