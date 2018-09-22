# frozen_string_literal: true

namespace :redis do
  %w[start stop restart].each do |command|
    desc "#{command.capitalize} redis"
    task command do
      on roles(:install) do
        execute :service, 'redis-server', command
      end
    end
  end
end