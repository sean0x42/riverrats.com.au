#!/bin/bash
# This file is meant to be executed via systemd.
source /usr/local/rvm/scripts/rvm
source /etc/profile.d/rvm.sh
export ruby_ver=$(rvm list default string)

export CONFIGURED=yes
export TIMEOUT=50
export APP_ROOT=/home/rails/river_rats/current
export RAILS_ENV="production"
export GEM_HOME="/home/rails/river_rats/shared/bundle/ruby/2.4.0/bin"
export GEM_PATH="/home/rails/river_rats/shared/bundle/ruby/2.4.0/bin:/usr/local/rvm/gems/${ruby_ver}:/usr/local/rvm/gems/${ruby_ver}@global"
export PATH="/home/rails/river_rats/shared/bundle/ruby/${ruby_ver}/bin:/usr/local/rvm/gems/${ruby_ver}/bin:${PATH}"

# Passwords
export SECRET_KEY_BASE=bbd9337ad068b11ce9276c1fb47b4074730163ed886951708258e04b68a355be0c0fb916b3eb41cc77d26e505d9a59c0068f963b46ffdbef9ca27f0c6773b93f
export APP_DATABASE_PASSWORD=e01156ce49aa49f8a15fdda502164cff

# Execute the unicorn process
/home/rails/river_rats/shared/bundle/ruby/2.4.0/bin/unicorn \
        -c /etc/unicorn.conf -E production --debug
