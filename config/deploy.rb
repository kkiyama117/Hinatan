# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.11.2'

set :application, 'Hinatan'
set :repo_url, 'git@github.com:kkiyama117/Hinatan.git'
set :user, 'ec2-user'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, '/home/ec2-user/Hinatan'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"
linked_files = %w[config/database.yml config/master.key config/credentials.yml.enc]
set :linked_files, fetch(:linked_files, []).concat(linked_files)

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs,
       'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system',
       '.bundle', 'vendor/bundle', 'public/uploads'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

# デプロイ先のサーバで、ユーザディレクトリでrbenvをインストールしている場合
# rbenvをシステムにインストールしたか? or ユーザーローカルにインストールしたか?
set :rbenv_type, :user # :system or :user
set :rbenv_path, '/home/ec2-user/.rbenv'
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w[rake gem bundle ruby rails foreman]
set :rbenv_roles, :all # default value

# pumaの設定
set :puma_threads, [4, 16]
set :puma_workers, 0
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log, "#{release_path}/log/puma.error.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true # Change to false when not using ActiveRecord
# rbenvをユーザローカルにインストールする場合に必要
append :rbenv_map_bins, 'puma', 'pumactl'

# Default value for keep_releases is 5
set :keep_releases, 3

# bundle installの並列実行数
set :bundle_jobs, 4

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end
  before :start, :make_dirs
end

# デプロイ用の追加タスク
namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      # 403 Forbidden対策
      execute 'chmod 701 /home/ec2-user'

      before 'deploy:restart', 'puma:start'
      after :fix_route_after_migrate, :db_seed
      invoke 'deploy'
    end
  end

  desc 'Remove devise routes because of migration error'
  task :fix_route_before_migrate do
    on roles(:app) do
      within "#{release_path}/config/" do
        execute :mv, 'routes.rb', 'routes.rb.tmp'
        execute :mv, 'routes.initial.rb', 'routes.rb'
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc 'db:seed'
  task :db_seed do
    on roles(:db) do |_host|
      with rails_env: fetch(:rails_env) do
        within release_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  desc 'Repair devise routes'
  task :fix_route_after_migrate do
    on roles(:app) do
      within "#{release_path}/config/" do
        execute :cp, 'routes.rb.tmp', 'routes.rb'
        execute :rm, 'routes.rb.tmp'
      end
    end
  end

  desc 'setup config'
  task :setup_config do
    on roles(:app) do |_host|
      linked_files.each do |f|
        upload! f.to_s, "#{shared_path}/#{f}"
      end
    end
  end

  desc 'setup nginx'
  task :nginx do
    on roles(:app) do |_host|
      # 後ほど作成するnginxのファイル名を記述してください
      # %w[AWS.conf].each do |f|
      # sudo :cp, "#{release_path}/nginx/#{f}", "/etc/nginx/conf.d/#{f}"
      # sudo 'systemctl reload nginx'
      # end
      sudo 'systemctl reload nginx'
    end
  end

  before :starting, :check_revision
  before :check, :setup_config
  after 'bundler:install', 'deploy:fix_route_before_migrate'
  after :migrate, :fix_route_after_migrate
  before :finishing, :nginx
  after :finishing, :compile_assets
  after :finishing, :cleanup
end
