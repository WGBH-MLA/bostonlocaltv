require "bundler/capistrano"

set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "bostonlocaltv"

set :repository,  "git@github.com:WGBH/bostonlocaltv.git"
set :scm, :git
set :branch, fetch(:branch, "master")

set :user, "dmyers"
set :use_sudo, false

set :deploy_to, "/wgbh/http/#{application}"
set :keep_releases, 10

after "deploy:restart", "deploy:cleanup"
before "deploy:assets:precompile","deploy:symlink_db"
after "deploy:update_code","deploy:symlink_jetty"
after "deploy:update_code", "deploy:symlink_uploads"

# To allow interactive login to lsboslocal02
default_run_options[:pty] = true
set :ssh_options, { :forward_agent => true }

namespace :deploy do 
  desc "Link the database/yml in to place"
  task :symlink_db do
    run "cp #{shared_path}/database.yml #{release_path}/config/database.yml"
  end

  desc "Link the uploads directory"
  task :symlink_uploads do
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :symlink_jetty do
    run "ln -nfs #{shared_path}/jetty #{latest_release}/jetty"
  end
end
