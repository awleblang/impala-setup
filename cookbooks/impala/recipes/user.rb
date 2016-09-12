#
# Cookbook Name:: impala
# Recipe:: user
#
# Copyright 2015, Cloudera Inc.
#
# All rights reserved - Do Not Redistribute
#
# Create and configure the impala developer user
#

# Create an .ssh directory and generate ssh keys if they don't exist
directory "/home/#{node['impala_dev']['username']}/.ssh" do
  owner node['impala_dev']['username']
  group node['impala_dev']['username']
  action :create
end

bash 'generate_ssh_keys' do
  user node['impala_dev']['username']
  not_if "test -f /home/#{node['impala_dev']['username']}/.ssh/id_rsa"
  code <<-EOH
  ssh-keygen -t rsa -N '' -q -f /home/#{node['impala_dev']['username']}/.ssh/id_rsa
  EOH
end

# Prepare the sudoers file 
include_recipe "sudo::default"

directory "/var/lib/hadoop-hdfs" do
  owner node['impala_dev']['username'] 
  group "root"
  action :create
end

user_ulimit node['impala_dev']['username'] do
  filehandle_limit 1048576
end
