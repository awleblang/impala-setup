#
# Copyright 2015, Cloudera Inc.
#
# All rights reserved - Do Not Redistribute
#

username = ''

# User options 
default['impala_dev']['username'] = username
default['impala_dev']['impala_home'] = "/home/#{default['impala_dev']['username']}/dev/cloudera"

# Java options
default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '7'
default['java']['oracle']['accept_oracle_download_terms'] = true

# Postgres options
case 
  when (node['platform_family'] == "debian" and node['platform_version'] == "15.04")
    default['postgresql']['pgdg']['release_apt_codename'] = 'trusty'
    default['postgresql']['version']  =                     '9.4'
    default['postgresql']['dir'] =                          "/etc/postgresql/#{default['postgresql']['version']}/main"
    default['postgresql']['client']['packages'] =           ["postgresql-client-#{default['postgresql']['version']}", "libpq-dev"]
    default['postgresql']['server']['packages'] =           ["postgresql-#{default['postgresql']['version']}"]
    default['postgresql']['contrib']['packages'] =          ["postgresql-contrib-#{default['postgresql']['version']}"]

    default['postgresql']['config']['data_directory'] =     "/var/lib/postgresql/#{default['postgresql']['version']}/main"
    default['postgresql']['config']['hba_file'] =           "/etc/postgresql/#{default['postgresql']['version']}/main/pg_hba.conf"
    default['postgresql']['config']['ident_file'] =         "/etc/postgresql/#{default['postgresql']['version']}/main/pg_ident.conf"
    default['postgresql']['config']['external_pid_file'] =  "/var/run/postgresql/#{default['postgresql']['version']}-main.pid"
  when (node['platform_family'] == "debian" and node['platform_version'] == "14.04")
    default['postgresql']['version'] = "9.3"
end

default['postgresql']['pg_hba'] = [{:type => 'local', :db => 'all', :user => 'postgres', :addr => nil, :method => 'trust'}, 
			           {:type => 'host', :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'trust'}, 
				   {:type => 'host', :db => 'all', :user => 'all', :addr => '::1/128', :method => 'trust'}]
default['postgresql']['password']['postgres'] = ''
default['postgresql']['config']['standard_conforming_strings'] = 'off'

# Hadoop LZO branch
default['hadoop-lzo']['branch'] = 'master'
# Impala LZO branch
default['impala-lzo']['branch'] = 'cdh5-trunk'
# Impala branch
default['impala']['branch'] = 'cdh5-trunk'

# Sudo setup
default['authorization']['sudo']['sudoers_defaults'] = [
  'env_reset',
  'secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"'
]
default['authorization']['sudo']['groups'] = ['admin', 'sudo']
default['authorization']['sudo']['users'] = [
  "root", "#{default['impala_dev']['username']}"]
default['authorization']['sudo']['passwordless'] = true
