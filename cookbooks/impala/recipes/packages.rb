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
  when node['platform_version'] == "15.10", node['platform_version'] == '15.04',
    node['platform_version'] == '14.04'
    Chef::Log.info('Version >= 14.04')
    packages = ["build-essential", "ant", "zlib1g-dev", "libbz2-dev", "python-dev",
         "automake", "libtool", "flex", "bison", "cmake", "pkg-config", "git",
         "libssl-dev", "subversion", "libevent1-dev", "libsasl2-dev", "libldap2-dev",
         "liblzo2-dev", "lzop", "maven", "libboost-all-dev", "ccache", "python-pycurl",
	 "libgnutls-dev", "libgnutls-dev", "python-pycurl", "wget", "ntp",
         "libncurses5-dev", "libkrb5-dev" ]
    packages.each do |pkg|
      package pkg
    end

    bash "install_boost" do
      user 'root'
      code <<-EOH
      cd /usr/lib/x86_64-linux-gnu
      if ! test -h libboost_filesystem-mt.so && test -f libboost_filesystem.so; then
        sudo ln -s libboost_filesystem.so libboost_filesystem-mt.so
      fi
      if ! test -h libboost_filesystem-mt.a && test -f libboost_filesystem.a; then
        sudo ln -s libboost_filesystem.a libboost_filesystem-mt.a
      fi
      if ! test -h libbost_system-mt.so && test -f libboost_system.so; then
        sudo ln -s libboost_system.so libboost_system-mt.so
      fi
      if ! test -h libboost_system-mt.a && test -f libboost_system.a; then
        sudo ln -s libboost_system.a libboost_system-mt.a
      fi
      if ! test -h libbost_regex-mt.so && test -f libboost_regex.so; then
        sudo ln -s libboost_regex.so libboost_regex-mt.so
      fi
      if ! test -h libboost_regex-mt.a && test -f libboost_regex.a; then
        sudo ln -s libboost_regex.a libboost_regex-mt.a
      fi
      EOH
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

# Setup LZO
bash 'setup_lzo' do
  user 'root'
  code <<-EOH
  if ! test -h /usr/lib/liblzo2.a && test -f /usr/lib/x86_64-linux-gnu/liblzo2.a; then
    ln -s /usr/lib/x86_64-linux-gnu/liblzo2.a /usr/lib/liblzo2.a
  fi
  if ! test -h /usr/lib/liblzo2.so && test -f /usr/lib/x86_64-linux-gnu/liblzo2.so; then
    ln -s /usr/lib/x86_64-linux-gnu/liblzo2.so /usr/lib/liblzo2.so
  fi
  EOH
end

include_recipe "java::default"
