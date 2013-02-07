set :applicationdir, "/home/transparencia/public_html/staging/#{application}"
set :deploy_to, "/home/transparencia/public_html/staging/#{application}"

role :web, "openwolf.transparencia.gob.gt"                          # Your HTTP server, Apache/etc
role :app, "openwolf.transparencia.gob.gt"                          # This may be the same as your `Web` server
role :db,  "openwolf.transparencia.gob.gt", :primary => true        # This is where Rails
role :solr, "openwolf.transparencia.gob.gt"

# migrations will run
set :backup_dir, "#{deploy_to}/backups"

set :branch, "master"

set :deploy_env, 'staging'
set :rails_env, "staging"

set :bundle_exec, ""
