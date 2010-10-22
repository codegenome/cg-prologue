create_file 'config/assets.yml' do
<<-FILE
embed_assets: on

javascripts:
  common:
    - public/javascripts/jquery.js
    - public/javascripts/rails.js

stylesheets:
  common:
    - public/stylesheets/main.css
FILE
end