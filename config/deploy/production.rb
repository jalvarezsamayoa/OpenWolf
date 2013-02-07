set :applicationdir, "/home/transparencia/public_html/#{application}"
set :deploy_to, "/home/transparencia/public_html/#{application}"

role :web, "openwolf.transparencia.gob.gt"                          # Your HTTP server, Apache/etc
role :app, "openwolf.transparencia.gob.gt"                          # This may be the same as your `Web` server
role :db,  "openwolf.transparencia.gob.gt", :primary => true # This is where
# Rails
role :solr, "openwolf.transparencia.gob.gt"

# migrations will run
set :backup_dir, "#{deploy_to}/backups"

set :branch, "master"

set :deploy_env, 'production'
set :rails_env, "production"

set :bundle_exec, "bundle exec"
