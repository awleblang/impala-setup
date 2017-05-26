#
# Cookbook Name:: impala
# Recipe:: packages
#
# Copyright 2015, Cloudera, Inc.
#
# All rights reserved - Do Not Redistribute
#

# Install packages

case node['platform_family']
when "debian"
  Chef::Log.info('Debian family')
  case
  when node['platform_version'] == "16.04", node['platform_version'] == "15.10", node['platform_version'] == '15.04',
    node['platform_version'] == '14.04'
    Chef::Log.info('Version >= 14.04')
    packages = ["g++", "gcc", "git", "libsasl2-dev", "make", "maven", "python-dev",
          "python-setuptools", "liblzo2-dev", "libkrb5-dev", "libffi-dev", "wget",
          "tmux", "ccache", "ninja-build", "ant", "emacs-nox", "vim"]
    packages.each do |pkg|
      package pkg
    end
  end
end

# Python packages
include_recipe "python::pip"

python_pkgs = ["python-jenkins"]

python_pkgs.each do |pkg|
  python_pip pkg do
    action :install
  end
end

bash 'update_ld_library_path' do
  user node['impala_dev']['username']
  code <<-EOH
    echo 'export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH' >> /home/#{node['impala_dev']['username']}/.bashrc
  EOH
end

include_recipe "impala::java"
