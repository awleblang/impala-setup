#
# Cookbook Name:: impala
# Recipe:: hbase
#
# Copyright 2015, Cloudera Inc.
#
# All rights reserved - Do Not Redistribute
#
# Setup HBase

bash 'setup_hbase_ssh' do
  user node['impala_dev']['username']
  code <<-EOH
  cd /home/#{node['impala_dev']['username']}
  cat .ssh/id_rsa.pub >> .ssh/authorized_keys
  chmod 600 .ssh/authorized_keys 
  ssh-keyscan -H github.com >> .ssh/known_hosts
  chmod 600 .ssh/known_hosts
  EOH
end
