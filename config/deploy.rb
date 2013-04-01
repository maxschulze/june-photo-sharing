require "bundler/capistrano"

set :application, "june-photo-sharing"
set :repository,  "git://github.com/maxschulze/june-photo-sharing.git"
set :deploy_via, :remote_cache

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "server.maxschulze.com"                          # Your HTTP server, Apache/etc
role :app, "server.maxschulze.com"                          # This may be the same as your `Web` server
role :db,  "server.maxschulze.com", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"
after "deploy:create_symlink", "deploy:symlink_uploads"
# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

set :use_sudo, false

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :symlink_uploads do
    run "mkdir -p #{deploy_to}/shared/uploads"
    run "ln -nfs  #{deploy_to}/shared/uploads #{deploy_to}/current/public/uploads"
  end
end