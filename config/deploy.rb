require "bundler/capistrano"
require 'capistrano/gitflow'

set :stages, %w(production, staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "bostonlocaltv"

set :repository,  "git@github.com:WGBH/bostonlocaltv.git"
set :scm, :git

set :user, "dmyers"
set :use_sudo, false

set :deploy_to, "/wgbh/http/#{application}"
set :keep_releases, 10

after "deploy:restart", "deploy:cleanup"
after "deploy:update_code","deploy:config_symlink"
after "deploy:update_code","deploy:symlink_jetty"

namespace :deploy do 
  desc "Link the database/yml in to place"
  task :config_symlink do
    run "cp #{shared_path}/database.yml #{release_path}/config/database.yml"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :symlink_jetty do
    run "ln -nfs #{shared_path}/jetty #{latest_release}/jetty"
  end
end