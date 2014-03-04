require 'capistrano/ext/multistage'
require 'capistrano/gitflow' 
require "bundler/capistrano"

set :application, "bostonlocaltv"
set :repository,  "git@github.com:WGBH/bostonlocaltv.git"

set :scm, :git
set :scm_command, "/usr/local/bin/git"
set :local_scm_command, "/usr/bin/git"
set :git_enable_submodules, 1

role :web, "your web-server here"                          # Your HTTP server, Apache/etc
role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

set :default_environment, {
  'PATH' => "/usr/local/bin:$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

set :ssh_options, { :forward_agent => true, :keys => File.join(ENV["HOME"], ".ssh", "id_rsa") }
set :use_sudo, false

# DREW: Set this to the remote path where rails apps are installed. If 
# this is different between staging and prod, move this declaration in the deploy/staging.rb file.
set :deploy_to, "/home/deploy/apps/#{application}"

set :chmod755, %w(app config db lib public vendor script tmp)
set :domain, "bostonlocaltv.org"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

after "deploy:update_code","deploy:config_symlink"

namespace :deploy do 
  desc "Link the database/yml in to place"
  task :config_symlink do
    run "cp #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
end
