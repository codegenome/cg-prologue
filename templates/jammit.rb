create_file 'config/assets.yml' do
<<-FILE
embed_assets: on

javascripts:
  common:
    - public/javascripts/jquery.js
    - public/javascripts/rails.js
    - public/javascripts/core.js

stylesheets:
  common:
    - public/stylesheets/main.css
FILE
end