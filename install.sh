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
  curl -L https://omnitruck.chef.io/install.sh | bash -s -- -v 12.3.0
fi

# Install git
sudo apt-get install -y git

# Get the location of this impala-setup/ repo
REPO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run chef-solo to configure the Impala dev machine
sudo -u $USER sed -i "s/username = ''/username = '$USER'/" $REPO_DIR/cookbooks/impala/attributes/default.rb
"$chef_binary" -c $REPO_DIR/solo.rb -j $REPO_DIR/impala.json
