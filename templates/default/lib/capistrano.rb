run 'capify .'

run 'rm config/deploy.rb'

create_file 'config/deploy.rb' do
<<-RUBY

# Variables

set :application, '#{app_name}'

set :stages, %w(staging production)
set :default_stage, 'staging'

# Options

default_run_options[:pty] = true

# Requires

require './config/boot'
require 'capistrano_colors'
require 'capistrano/ext/multistage'

require 'bundler/capistrano'
require 'hoptoad_notifier/capistrano'

# Callbacks

after 'deploy', 'deploy:cleanup'

# Custom tasks

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "\#{try_sudo} touch \#{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

RUBY
end

run 'mkdir -p config/deploy'

create_file 'config/deploy/staging.rb' do
<<-RUBY
set :rails_env, 'staging'

set :repository, 'git@github.com:...'
set :scm, 'git'
set :branch, 'staging'
set :deploy_via, :remote_cache

set :address, '...'

role :web, address
role :app, address
role :db,  address, :primary => true

set :user, 'deploy'
set :deploy_to, "/var/www/\#{application}"
set :use_sudo, false
RUBY
end

create_file 'config/deploy/production.rb' do
<<-RUBY
set :rails_env, 'production'

set :repository, 'git@github.com:...'
set :scm, 'git'
set :branch, 'production'
set :deploy_via, :remote_cache

set :address, '...'

role :web, address
role :app, address
role :db,  address, :primary => true

set :user, 'deploy'
set :deploy_to, "/var/www/\#{application}"
set :use_sudo, false
RUBY
end
