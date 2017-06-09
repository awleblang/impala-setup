#
# Cookbook Name:: impala
# Recipe:: java
#
# Copyright 2015, Cloudera Inc.
#
# All rights reserved - Do Not Redistribute
#
# Install Oracle Java

bash 'instal_java' do
  user 'root'
  code <<-EOH
    add-apt-repository ppa:openjdk-r/ppa
    apt-get update
    apt-get install -y openjdk-7-jdk
    echo "export JAVA_HOME=#{node['java']['home']}" >> /home/#{node['impala_dev']['username']}/.bashrc
  EOH
  environment "JAVA_HOME" => node['java']['home']
end
