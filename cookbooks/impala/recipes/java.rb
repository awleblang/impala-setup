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
    apt-get install -y python-software-properties debconf-utils
    add-apt-repository -y ppa:webupd8team/java
    apt-get update
    echo "oracle-java#{node['java']['version']}-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
    apt-get install -y oracle-java#{node['java']['version']}-installer
    echo "export JAVA_HOME=#{node['java']['home']}" >> /home/#{node['impala_dev']['username']}/.bashrc
  EOH
  environment "JAVA_HOME" => node['java']['home']
end
