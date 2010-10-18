create_file 'config/assets.yml' do
<<-FILE
embed_assets: on

javascripts:
  common:
    - public/javascriptsjquery.js

stylesheets:
  common:
    - public/stylesheets/main.css
FILE
end