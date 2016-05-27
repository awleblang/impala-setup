#
# Cookbook Name:: impala
# Recipe:: machine
#
# Copyright 2015, Cloudera Inc.
#
# All rights reserved - Do Not Redistribute
#

bash 'fix_hosts' do
  user 'root'
  ignore_failure true
  code <<-EOH
  sed -i 's/127.0.1.1/127.0.0.1/g' /etc/hosts
  EOH
end
