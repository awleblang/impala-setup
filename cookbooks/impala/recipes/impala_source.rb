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

bash "setup_impala_home" do
  user node['impala_dev']['username']
  code <<-EOH
  mkdir -p #{node['impala_dev']['impala_home']}
  EOH
end

