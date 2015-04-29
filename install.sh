#!/bin/bash
#
# Copyright 2015, Cloudera Inc.
#
# All rights reserved - Do Not Redistribute
#

if [ $USER != "root" ]; then
  echo "install.sh must be run as root (sudo ./install.sh)"
  exit 1
fi

USER=$SUDO_USER
USER_HOME=$(eval echo ~${SUDO_USER})

sudo apt-get install -y curl

chef_binary=/usr/bin/chef-solo
# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
  export DEBIAN_FRONTEND=noninteractive
  # Install Chef
  curl -L https://www.opscode.com/chef/install.sh | bash
fi

# Install git
sudo apt-get install -y git

cd $USER_HOME
if ! test -d impala-setup; then
  sudo -u $USER git clone https://github.com/awleblang/impala-setup.git
  cd impala-setup
else
  cd impala-setup
  sudo -u $USER git pull
fi

# Run chef-solo to configure the Impala dev machine
sudo -u $USER sed -i "s/username = ''/username = '$USER'/" cookbooks/impala/attributes/default.rb
"$chef_binary" -c solo.rb -j impala.json
