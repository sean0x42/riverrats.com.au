# frozen_string_literal: true

root = '/home/rails/river_rats/current'
working_directory root

stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

worker_processes ENV.fetch('RAILS_MAX_THREADS') { 5 }
timeout 30
preload_app true

listen '/var/sockets/unicorn.river_rats.sock', backlog: 64

before_fork do
  Signal.trap 'TERM' do
    Rails.logger.debug t('log.intercept_term')
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
end

after_fork do
  Signal.trap 'TERM' do
    Rails.logger.debug t('log.term_trap')
  end

  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
  ENV['BUNDLE_GEMFILE'] = File.join(root, 'Gemfile')
end
