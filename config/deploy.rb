# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'Testtask'

set :repo_url, 'https://github.com/sathibabu-nyros/Testtask'
set :rbenv_ruby, '2.3.0'
set :scm, :git
#set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/ec2_1_Nyros.ppk) }
set :ssh_options, {
  keys: %w(~/.ssh/ec2_1_Nyros.pem),
  forward_agent: false,
  user: 'ubuntu'
} 
set :deploy_to, "/home/ubuntu/Testtask"
set :pty, true


set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 2

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "/home/ubuntu/Testtask/shared/tmp/pids/puma.state"
set :puma_pid, "/home/ubuntu/Testtask/shared/tmp/pids/puma.pid"
set :puma_bind, "unix:///home/ubuntu/Testtask/shared/tmp/sockets/puma.sock"    #accept array for multi-bind
set :puma_conf, "/home/ubuntu/Testtask/shared/puma.rb"
set :puma_access_log, "/home/ubuntu/Testtask/shared/log/puma_error.log"
set :puma_error_log, "/home/ubuntu/Testtask/shared/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, true







# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
        execute :rake, 'cache:clear'
      end
    end
  end

end
