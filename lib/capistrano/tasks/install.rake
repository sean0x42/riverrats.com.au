namespace :install do

  desc "Installs RVM"
  task :rvm do
    on roles(:all) do
      execute sudo :gpg, '--keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB'
      execute :curl, '-sSL', 'https://get.rvm.io | sudo bash -s stable --ruby'
      execute sudo 'apt-get', :install, '-y', 'build-essential', 'openssl', 'libreadline6', 'libreadline6-dev', 'git-core', 'zlib1g', 'zlib1g-dev', 'libssl-dev', 'libyaml-dev', 'libsqlite3-dev', 'sqlite3', 'libxml2-dev', 'libxslt-dev', 'autoconf', 'libc6-dev', 'ncurses-dev', 'automake', 'libtool', 'bison', 'subversion'
    end
  end

  desc "Installs bundler"
  task :bundler do
    on roles(:all) do
      execute sudo 'gem install bundler --no-rdoc --no-ri'
    end
  end
  after :rvm, :bundler

  desc "Installs Yarn package manage"
  task :yarn do
    on roles(:all) do
      execute :curl, '-sSL', 'https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -'
      execute :echo, "\"deb https://dl.yarnpkg.com/debian/ stable main\" | sudo tee /etc/apt/sources.list.d/yarn.list"
      execute sudo 'apt-get', :update
      execute sudo 'apt-get', :install, '-y', :yarn
    end
  end
  after :rvm, :yarn

  desc "Installs Nginx"
  task :nginx do
    on roles(:all) do
      execute sudo 'apt-get', :update
      execute sudo 'apt-get', :install, '-y', :nginx
      execute sudo :ufw, :allow, "'Nginx Full'"
    end
  end
  after :rvm, :nginx

  # This is not done yet
  desc "Copies the sample Nginx config file"
  task :copy_nginx_config do
    on roles(:all) do
      # upload! 'config/remote/river_rats.conf', "/etc/nginx/sites-available/#{fetch(:application)}"
      execute sudo :ln, '-s', "/etc/nginx/sites-available/#{fetch(:application)}", '/etc/nginx/sites-enabled/'
    end
  end
  after :nginx, :copy_nginx_config

  desc "Installs Phusion Passenger"
  task :passenger do
    on roles(:all) do
      # Install PGP key and add HTTPS support for APT
      execute sudo 'apt-get', :update
      execute sudo 'apt-get', :install, '-y', :dirmngr, :gnupg
      execute sudo 'apt-key', :adv, '--keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7'
      execute sudo 'apt-get', :install, '-y', 'apt-transport-https', 'ca-certificates'

      # Add APT repository
      execute sudo :sh, "-c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list'"
      execute sudo 'apt-get', :update
      execute sudo 'apt-get', :install, '-y', 'nginx-extras', :passenger

      # Uncomment line in nginx.conf
      execute sudo :sed, '-i', '-e', "'s/# include \\/etc\\/nginx\\/passenger.conf/include \\/etc\\/nginx\\/passenger.conf/g'", "/etc/nginx/nginx.conf"
      execute sudo :service, :nginx, :restart
    end
  end
  after :nginx, :passenger

  # This is not done yet
  desc "Installs Certbot"
  task :certbot do
    on roles(:all) do
      execute sudo 'apt-get', :update
      execute sudo 'apt-get', :install, '-y', 'software-properties-common'
      execute sudo 'add-apt-repository', 'ppa:certbot/certbot'
      execute sudo 'apt-get', :update
      execute sudo 'apt-get', :install, '-y', 'python-certbot-nginx'
      execute sudo :certbot, '--nginx', '--noninteractive', '-m sean@seanbailey.io', '--agree-tos', "-d #{fetch(:domain)}"
      info "Installed Certbot on #{host}"
    end
  end

  desc "Installs Elasticsearch"
  task :elasticsearch do
    on roles(:all) do
      execute :wget, '-q', 'https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.3.1/elasticsearch-2.3.1.deb'
      execute sudo :dpkg, '-i', 'elasticsearch-2.3.1.deb'
      execute sudo :systemctl, :enable, 'elasticsearch.service'
    end
  end

  # This is not done yet
  desc "Installs PostgreSQL"
  task :postgres do
    on roles(:all) do
      execute sudo 'apt-get', :update
      execute sudo 'apt-get', :install, '-y', :postgresql, 'postgresql-contrib'
      as :postgres do
        user = fetch(:database_user, 'rails')
        execute :createuser, '-w', '-d', user, '|| true'
        execute :createdb, "-O #{user} #{fetch(:application)}"
        execute :psql, "-U #{user}", "-d #{fetch(:application)}", "-c \"ALTER USER #{user} WITH PASSWORD 'd5e2a624f5fc1de17201589fedc2e4d28';\""
      end
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