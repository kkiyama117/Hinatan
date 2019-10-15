# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.11.2'

set :application, 'R'
set :repo_url, 'git@github.com:kkiyama117/R.git'
set :user, 'ec2-user'

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"
set :deploy_to, '/home/ec2-user/R'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default value for :format is :airbrussh.
set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push(
    'config/database.ym l', 'config/master.key', 'config/credentials.yml.enc')

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs,
       'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', '.bundle', 'vendor/bundle'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

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
      invoke 'deploy'
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
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  before :starting, :check_revision
  before :check, 'setup:config'
  after :migrate, :seed
  after :finishing, :compile_assets
  after :finishing, :cleanup
end

namespace :setup do
  desc 'setup config'
  task :config do
    on roles(:app) do |_host|
      # rails5.2以前だとmaster.keyではなくて、secret.ymlになるはずです。
      %w[master.key database.yml credentials.yml.enc].each do |f|
        upload! "config/#{f}", "#{shared_path}/config/#{f}"
      end
    end
  end

  # desc 'setup nginx'
  # task :nginx do
  #   on roles(:app) do |_host|
  # 後ほど作成するnginxのファイル名を記述してください
  # %w[perican3.conf].each do |f|
  #   upload! "config/#{f}", "#{shared_path}/config/#{f}"
  #   sudo :cp, "#{shared_path}/config/#{f}", "/etc/nginx/conf.d/#{f}"
  #   sudo 'nginx -s reload'
  # end
  # end
  # end
end
