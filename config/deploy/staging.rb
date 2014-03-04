set :server, 'IP Address of STAGE here'

role :app, 'deploy_user@stage_host'
role :web, 'deploy_user@stage_host'
role :db,  'deploy_user@stage_host', :primary => true

# set (:bundle_cmd) { "~/.rbenv/shims/bundle" }
