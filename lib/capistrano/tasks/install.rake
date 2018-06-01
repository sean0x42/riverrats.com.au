namespace :install do

  desc "Installs Ruby"
  task :ruby do
    on roles(:install) do |host|
      execute 'apt-get', :update
      execute 'apt-get', :install, '-y', 'ruby-full'
      info "Installing Ruby on #{host}"
    end
  end

  desc "Installs bundler"
  task :bundler do
    on roles(:install) do |host|
      execute 'gem install bundler --no-rdoc --no-ri'
    end
  end
  after :ruby, :bundler

  desc "Installs Yarn package manage"
  task :yarn do
    on roles(:install) do |host|
      execute :curl, '-sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -'
      execute :echo, "\"deb https://dl.yarnpkg.com/debian/ stable main\" | sudo tee /etc/apt/sources.list.d/yarn.list"
      execute 'apt-get', :update
      execute 'apt-get', :install, '-y', :yarn
      info "Installed Yarn package manager on #{host}"
    end
  end

  desc "Installs Nginx"
  task :nginx do
    on roles(:install) do |host|
      execute 'apt-get', :update
      execute 'apt-get', :install, '-y', :nginx
      execute :ufw, :allow, "'Nginx Full'"
      info "Installed Nginx on #{host}"
    end
  end

  # This is not done yet
  desc "Copies the sample Nginx config file"
  task :copy_nginx_config do
    on roles(:install) do
      upload! 'config/remote/river_rats.conf', "/etc/nginx/sites-available/#{retrieve(:application)}.conf"
      info "Copied nginx config files to #{host}"
    end
  end

  desc "Installs Phusion Passenger"
  task :passenger do
    on roles(:install) do |host|
      # Install PGP key and add HTTPS support for APT
      execute 'apt-get', :update
      execute 'apt-get', :install, '-y', :dirmngr, :gnupg
      execute 'apt-key', :adv, '--keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7'
      execute 'apt-get', :install, '-y', 'apt-transport-https', 'ca-certificates'

      # Add APT repository
      execute :sh, "-c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list'"
      execute 'apt-get', :update
      execute 'apt-get', :install, '-y', 'nginx-extras', :passenger

      # Uncomment line in nginx.conf
      execute :sed, '-i', '-e', "'s/# include \\/etc\\/nginx\\/passenger.conf/include \\/etc\\/nginx\\/passenger.conf/g'", "/etc/nginx/nginx.conf"
      execute :service, :nginx, :restart
      info "Installed Phusion Passenger on #{host}"
    end
  end

  # This is not done yet
  desc "Installs Certbot"
  task :certbot do
    on roles(:install) do
      execute 'apt-get', :update
      execute 'apt-get', :install, '-y', 'software-properties-common'
      execute 'add-apt-repository', 'ppa:certbot/certbot'
      execute 'apt-get', :update
      execute 'apt-get', :install, '-y', 'python-certbot-nginx'
      execute :certbot, '--nginx', interaction_handler: {
        "Enter email address (used for urgent renewal and security notices) (Enter 'c' to cancel):
" => "sean@seanbailey.io"
      }
      info "Installed Certbot on #{host}"
    end
  end

  desc "Installs Elasticsearch"
  task :elastic_search do
    on roles(:install) do
      execute :wget, '-q', 'https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.3.1/elasticsearch-2.3.1.deb'
      execute :dpkg, '-i', 'elasticsearch-2.3.1.deb'
      execute :systemctl, :enable, 'elasticsearch.service'
      info "Installed Elasticsearch on #{host}"
    end
  end

  # This is not done yet
  desc "Installs PostgreSQL"
  task :postgres do
    on roles(:install) do
      execute 'apt-get', :update
      execute 'apt-get', :install, '-y', :postgresql, 'postgresql-contrib'
      as :postgres do
        execute :createuser, '-w', '-d', fetch(:database_user, 'rails_dev'), '|| true'
        execute :createdb, "-O #{fetch(:database_user, 'rails_dev')} #{fetch(:application)}"
      end
      info "Installed PostgreSQL on #{host}"
    end
  end

  desc "Installs Redis"
  task :redis do
    on roles(:install) do
      execute 'apt-get', :update
      execute 'apt-get', :install, '-y', 'redis-server'
      info "Installed Redis on #{host}"
    end
  end

end

desc "Updates all packages via APT"
task :update do
  on roles(:install) do |host|
    execute 'apt-get', :update
    execute 'apt-get', '-y', :upgrade
    info "Updated all packages on #{host}"
  end
end