run 'capify .'

run 'rm config/deploy.rb'

run 'cp config/environments/production.rb config/environments/staging.rb'

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

after('deploy:update_code',
      'db:symlink',
      'assets:create_dirs')

after 'deploy:symlink', 'assets:precompile'

after 'deploy', 'deploy:cleanup'

# Custom tasks

namespace :assets do
  task :create_dirs, :roles => :app do
    run "mkdir -p #{release_path}/app/assets/stylesheets/main"
    run "mkdir -p #{release_path}/app/assets/stylesheets/admin"
  end

  task :precompile, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{stage} rake assets:precompile"
  end
end

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "\#{try_sudo} touch \#{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :db do
  task :symlink, :roles => :app do
    run "ln -ns #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end
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
