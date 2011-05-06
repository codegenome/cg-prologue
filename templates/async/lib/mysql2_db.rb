# Add the mysql2 gem
gem "mysql2" , "~> 0.2.7"

# Redefine our database.yml using the async adapters
run 'rm config/database.yml'
create_file 'config/database.yml' do
<<-FILE
development:
  adapter: em_mysql2
  database: rails_async_development
  username: root
  pool: 250
  timeout: 5000

test:
  adapter: em_mysql2
  database: rails_async_test
  username: root
  pool: 5
  timeout: 5000

FILE
end

