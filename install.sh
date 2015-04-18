#!/bin/bash
#
# Copyright 2015, Cloudera Inc.
#
# All rights reserved - Do Not Redistribute
#
# This runs as root on the server

chef_binary=/usr/bin/chef-solo

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
  export DEBIAN_FRONTEND=noninteractive
  curl -L https://www.opscode.com/chef/install.sh | bash
fi

git clone

echo "cookbook_path [ '${PWD}/cookbooks' ]" > .chef/knife.rb

"$chef_binary" -c solo.rb -j impala.json
