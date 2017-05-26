#
# Cookbook Name:: impala
# Recipe:: postgres
#
# Copyright 2015, Cloudera Inc.
#
# All rights reserved - Do Not Redistribute
#
include_recipe "postgresql::server"

service 'postgresql' do
  action :restart
end

bash 'setup_pg_roles' do
  user 'postgres'
  code <<-EOH
  psql -c "CREATE ROLE hiveuser LOGIN PASSWORD 'password';" postgres || true
  psql -c "ALTER ROLE hiveuser WITH CREATEDB;" postgres || true
  sed -i 's/local   all             all                                     peer/local   all             all                                     trust/g' #{node['postgresql']['config']['hba_file']}
  EOH
end

service 'postgresql' do
  action :restart
end
