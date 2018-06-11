# config valid for current version and patch releases of Capistrano
lock '~> 3.10.2'

set :application, 'river_rats'
set :repo_url, 'git@github.com:LuckehPickle/riverrats.com.au.git'
set :branch, 'master'
set :domain, 'riverrats.com.au'
set :rvm_ruby_version, '2.4.1'
set :rails_env, 'production'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/rails/#{fetch(:application)}"
set :use_sudo, false
set :bundle_binstubs, nil
set :deploy_via, :remote_cache

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  desc "reload the database with seed data"
  task :seed do
    on roles(:all) do
      within "#{fetch(:deploy_to)}/current" do
        execute :bundle, :exec, :rake, "db:seed RAILS_ENV=#{fetch(:rails_env)}"
      end
    end
  end
end


# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'


# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
