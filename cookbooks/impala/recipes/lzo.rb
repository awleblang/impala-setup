#
# Cookbook Name:: impala
# Recipe:: lzo
#
# Copyright 2015, Cloudera Inc.
#
# All rights reserved - Do Not Redistribute
#
# Setup lzo sources

git "/home/#{node['impala_dev']['username']}/hadoop-lzo" do
  repository 'https://github.com/cloudera/hadoop-lzo.git'
  user node['impala_dev']['username']
  revision node['hadoop-lzo']['branch']
  action :checkout
end

git "/home/#{node['impala_dev']['username']}/Impala-lzo" do
  repository 'https://github.com/cloudera/impala-lzo.git'
  user node['impala_dev']['username']
  revision node['impala-lzo']['branch']
  action :checkout
end

bash 'build_lzo' do
  user node['impala_dev']['username']
  code <<-EOH
  cd /home/#{node['impala_dev']['username']}/Impala-lzo/
  git checkout #{node['impala-lzo']['branch']}
  cd /home/#{node['impala_dev']['username']}/hadoop-lzo/
  git checkout #{node['hadoop-lzo']['branch']}
  ant package
  EOH
  environment "JAVA_HOME" => node['java']['home']
end
