set :application, "prospektor"
set :repository,  "git@github.com:adamstrickland/prospektor.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

slice = "li108-53.members.linode.com"

role :web, slice                          # Your HTTP server, Apache/etc
role :app, slice                          # This may be the same as your `Web` server
role :db,  slice, :primary => true        # This is where Rails migrations will run
# role :db,  "your slave db-server here"

set :deploy_to, "/var/www"

set :user, "adamstrickland"
set :ssh_options, { :port => 2422 }
set(:root_password) { Capistrano::CLI.password_prompt("Root password: ") }

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start {}
#   task :stop {}
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
namespace :deploy do
  task :start, :roles => :app do
    run "#{try_sudo} /etc/init.d/thin start"
  end
  
  task :start, :roles => :app do
    run "#{try_sudo} /etc/init.d/thin stop"
  end
  
  task :restart, :rles => :app do
    run "#{try_sudo} /etc/init.d/thin restart"
  end
end