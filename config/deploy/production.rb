set :server, 'IP Address of PROD here'

role :app, 'deploy_user@prod_host'
role :web, 'deploy_user@prod_host'
role :db,  'deploy_user@prod_host', :primary => true

# set (:bundle_cmd) { "~/.rbenv/shims/bundle" }
