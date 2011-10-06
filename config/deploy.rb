set :stages, %w(production staging)
set :default_stage, "staging"

require 'bundler/capistrano'
require 'delayed/recipes'
require 'capistrano/ext/multistage'

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.8.7'
set :rvm_bin_path, "/usr/local/rvm/bin"

set :rails_root, "#{File.dirname(__FILE__)}/.."
require "#{rails_root}/config/capistrano_database_yml.rb"

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

default_run_options[:pty] = true

set :application, "openwolf"
set :user, "transparencia"

set :scm, "git"
set :repository, "git://gitorious.org/openwolf/openwolf_v3.git"
set :deploy_via, :remote_cache
set :use_sudo, false

#set :git_enable_submodules, 1

task :uname do
  run "uname -a"
end


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:symlink", :symlink_gems

before "deploy:update_code", "solr:stop"
after "deploy:symlink", "solr:symlink"
after "solr:symlink", "solr:start"
#after "solr:start", "solr:reindex"

before "deploy:restart", "delayed_job:stop"
after  "deploy:restart", "delayed_job:start"

after "deploy:stop",  "delayed_job:stop"
after "deploy:start", "delayed_job:start"


desc "Vincular directorio de gems"
task :symlink_gems, :roles => :app do
  puts "\n\n=== Vinculando Gems ===\n\n"
  run <<-CMD
    cd #{release_path} &&
    ln -nfs #{shared_path}/bundle #{current_path}/vendor/gems &&
    bundle install --path vendor/gems
  CMD
end

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
      rake sunspot:solr:stop RAILS_ENV=#{rails_env} > /dev/null 2> /dev/null
    CMD
  end

  desc "After update_code you want to restart SOLR in a specific environment"
  task :start, :roles => :solr do
    run <<-CMD
      cd #{current_path} &&
      nohup rake sunspot:solr:start RAILS_ENV=#{rails_env} > #{shared_path}/log/solr.log 2> #{shared_path}/log/solr.err.log
    CMD
  end

  desc "Reindexar solr"
  task :reindex, :roles => :solr do
    run <<-CMD
      cd #{current_path} &&
      rake sunspot:solr:reindex RAILS_ENV=#{rails_env}
    CMD
  end
end

task :backup, :roles => :db, :only => { :primary => true } do
  puts "Remove old backups"
  run <<-CMD
     cd #{backup_dir} &&
     rm *.bz2
  CMD

  timestamp = Time.now.to_f
  filename = "#{application}.dump.#{timestamp}.sql.bz2"
  clean_filename = "#{application}.dump.#{timestamp}.sql"
   file_path = "#{backup_dir}/" + filename
   text = capture "cat #{deploy_to}/current/config/database.yml"
   yaml = YAML::load(text)
 
  on_rollback { run "rm #{file_path}" }

  puts "Backup database..."
  run "pg_dump --clean --no-owner --no-privileges -U#{yaml['production']['username']} -h#{yaml['production']['host']} #{yaml['production']['database']} | bzip2 > #{file_path}" do |ch, stream, out|
    ch.send_data "#{yaml['production']['password']}\n" if out =~ /^Password:/
    puts out
  end

  puts "Downloading file..."
  download(file_path, "/home/javier/Backup/#{filename}")

  puts "Extracting file"
  system("bunzip2 /home/javier/Backup/#{filename}")
  system("psql -h localhost -p 5432 -U openwolf -W -d openwolf_development < /home/javier/Backup/#{clean_filename}")

  
end


Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'config/boot'
require 'hoptoad_notifier/capistrano'
