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
    echo "127.0.0.1 $(hostname -s) $(hostname)" | tee -a /etc/hosts
    sed -i 's/127.0.1.1/127.0.0.1/g' /etc/hosts
  EOH
end

bash 'hdfs_workaround' do
  user 'root'
  code <<-EOH
    mkdir /var/lib/hadoop-hdfs
    chown #{node['impala_dev']['username']} /var/lib/hadoop-hdfs/
    echo "*               hard    nofile          1048576" | tee -a /etc/security/limits.conf
    echo "*               soft    nofile          1048576" | tee -a /etc/security/limits.conf
  EOH
end

bash 'ssh' do
  user node['impala_dev']['username']
  code <<-EOH
    ssh-keygen -t rsa -N '' -q -f /home/#{node['impala_dev']['username']}/.ssh/id_rsa
    cat /home/#{node['impala_dev']['username']}/.ssh/id_rsa.pub >> /home/#{node['impala_dev']['username']}/.ssh/authorized_keys
    chmod 600 .ssh/authorized_keys
    ssh-keyscan -H github.com >> /home/#{node['impala_dev']['username']}/.ssh/known_hosts
    chmod 600 .ssh/authorized_keys
    echo "NoHostAuthenticationForLocalhost yes" >> /home/#{node['impala_dev']['username']}/.ssh/config
  EOH
end
