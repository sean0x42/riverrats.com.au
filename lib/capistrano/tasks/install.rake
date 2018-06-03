namespace :install do

  # desc "Installs bundler"
  # task :bundler do
  #   on roles(:all) do
  #     execute sudo 'gem install bundler --no-rdoc --no-ri'
  #   end
  # end
  # after :rvm, :bundler

  desc "Installs Yarn package manage"
  task :yarn do
    on roles(:all) do
      execute :curl, '-sSL', 'https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -'
      execute :echo, "\"deb https://dl.yarnpkg.com/debian/ stable main\" | sudo tee /etc/apt/sources.list.d/yarn.list"
      execute sudo 'apt-get', :update
      execute sudo 'apt-get', :install, '-y', :yarn
    end
  end

  # This is not done yet
  # desc "Copies the sample Nginx config file"
  # task :copy_nginx_config do
  #   on roles(:all) do
  #     # upload! 'config/remote/river_rats.conf', "/etc/nginx/sites-available/#{fetch(:application)}"
  #     execute sudo :ln, '-s', "/etc/nginx/sites-available/#{fetch(:application)}", '/etc/nginx/sites-enabled/'
  #   end
  # end
  # after :nginx, :copy_nginx_config

  desc "Installs Elasticsearch"
  task :elasticsearch do
    on roles(:all) do
      execute :wget, '-q', 'https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.3.1/elasticsearch-2.3.1.deb'
      execute sudo :dpkg, '-i', 'elasticsearch-2.3.1.deb'
      execute sudo :systemctl, :enable, 'elasticsearch.service'
    end
  end

  desc "Installs Redis"
  task :redis do
    on roles(:all) do
      execute sudo 'apt-get', :update
      execute sudo 'apt-get', :install, '-y', 'redis-server'
    end
  end

end

desc "Updates all packages via APT"
task :update do
  on roles(:all) do
    execute sudo 'apt-get', :update
    execute sudo 'apt-get', '-y', :upgrade
    execute sudo 'apt-get', '-y', :autoremove
  end
end

task :check_apt_dependencies do
  on roles(:all) do
    execute sudo 'apt-get', :install, '-y', 'build-essential', 'ruby-dev', 'openssl', 'libreadline6', 'libreadline6-dev', 'git-core', 'zlib1g', 'zlib1g-dev', 'libssl-dev', 'libyaml-dev', 'libsqlite3-dev', 'sqlite3', 'libxml2-dev', 'libxslt-dev', 'autoconf', 'libc6-dev', 'ncurses-dev', 'automake', 'libtool', 'bison', 'subversion', 'patch', 'liblzma-dev', 'libgmp-dev', 'libpq-dev'
  end
end