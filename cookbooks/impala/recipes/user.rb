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

cookbook_file "bashrc" do
  path "/home/#{node['impala_dev']['username']}/.bashrc"
  action :create
end

directory "/home/#{node['impala_dev']['username']}/.ssh" do
  owner node['impala_dev']['username']
  group node['impala_dev']['username']
  action :create
end

bash 'generate_ssh_keys' do
  user node['impala_dev']['username']
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
