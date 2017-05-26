#
# Cookbook Name:: impala
# Recipe:: java
#
# Copyright 2015, Cloudera Inc.
#
# All rights reserved - Do Not Redistribute
#
# Install Oracle Java 8

bash 'instal_java_8' do
  user 'root'
  code <<-EOH
    apt-get install -y python-software-properties debconf-utils
    add-apt-repository -y ppa:webupd8team/java
    apt-get update
    echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
    apt-get install -y oracle-java8-installer
    echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /home/#{node['impala_dev']['username']}/.bashrc
  EOH
  environment "JAVA_HOME" => "/usr/lib/jvm/java-8-oracle"
end
