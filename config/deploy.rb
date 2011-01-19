#require 'capistrano/deepmodules'
#hello world

default_run_options[:pty] = true

set :application, "openwolf"
set :applicationdir, "/home/transparencia/public_html/#{application}"
role :web, "transparencia.gob.gt"
role :db,  "transparencia.gob.gt", :primary => true
role :app, "transparencia.gob.gt"
role :solr, 'transparencia.gob.gt'

set :user, "transparencia"
set :deploy_to, "/home/transparencia/public_html/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
#set :repository, "git@gitorious.org:openwolf/openwolf.git"
set :repository, "git://gitorious.org/openwolf/openwolf_v3.git"
set :branch, "master"
set :git_enable_submodules, 1

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end


before "deploy:update_code", "solr:stop"
after "deploy:symlink", "solr:symlink"
after "solr:symlink", "solr:start"

namespace :solr do
  desc "Link in solr directory"
  task :symlink, :roles => :solr do
    run <<-CMD
      cd #{release_path} &&
      ln -nfs #{shared_path}/solr #{release_path}/solr 
    CMD
  end
  
  desc "Before update_code you want to stop SOLR in a specific environment"
  task :stop, :roles => :solr do
    run <<-CMD
      cd #{current_path} &&
      rake sunspot:solr:stop RAILS_ENV=production
    CMD
  end
  
  desc "After update_code you want to restart SOLR in a specific environment"
  task :start, :roles => :solr do
    run <<-CMD
      cd #{current_path} &&
      nohup rake sunspot:solr:start RAILS_ENV=production > #{shared_path}/log/solr.log 2> #{shared_path}/log/solr.err.log
    CMD
  end

  
  
end



# task :init_prawn_submodules do
# #  run "cd #{release_path} && git submodule add https://github.com/sandal/prawn.git vendor/prawn"
#   run "cd #{release_path}/vendor/prawn && git submodule init"
#   run "cd #{release_path}/vendor/prawn && git checkout origin/stable && git checkout -b stable"
#   run "cd #{release_path}/vendor/prawn && git submodule update --init"
# end

#after "deploy:update_code", :init_prawn_submodules


# set :application, "openwolf"
# set :repository,  "set your repository location here"

# set :scm, :subversion
# # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end


Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'config/boot'
require 'hoptoad_notifier/capistrano'
