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
  when node['platform_version'] == '14.04'
    Chef::Log.info('Version 14.04')
    packages = ["build-essential", "ant", "zlib1g-dev", "libbz2-dev", "python-dev", 
	 "automake", "libtool", "flex", "bison", "cmake", "pkg-config", "git", 
	 "libssl-dev", "subversion", "libevent1-dev", "libsasl2-dev", "libldap2-dev", 
	 "liblzo2-dev", "lzop", "maven", "libboost-all-dev", "ccache"]
    packages.each do |pkg|
      package pkg
    end

    bash "install_boost" do
      user 'root'
      code <<-EOH
      cd /usr/lib/x86_64-linux-gnu
      if ! test -f libboost_filesystem-mt.so; then
        sudo ln -s libboost_filesystem.so libboost_filesystem-mt.so
      fi
      if ! test -f libboost_filesystem-mt.a; then
        sudo ln -s libboost_filesystem.a libboost_filesystem-mt.a
      fi
      if ! test -f libbost_system-mt.so; then
        sudo ln -s libboost_system.so libboost_system-mt.so
      fi
      if ! test -f libboost_system-mt.a; then
        sudo ln -s libboost_system.a libboost_system-mt.a
      fi
      if ! test -f libbost_regex-mt.so; then
        sudo ln -s libboost_regex.so libboost_regex-mt.so
      fi
      if ! test -f libboost_regex-mt.a; then
        sudo ln -s libboost_regex.a libboost_regex-mt.a
      fi
      EOH
    end
  when node['platform_version'] == '12.04'
    packages = ["build-essential", "ant", "libboost-dev", "libboost-thread-dev", 
	  "libboost-test-dev", "libboost-program-options-dev", 
	  "libboost-regex-dev", "libboost-system-dev", "libboost-filesystem-dev", 
	  "zlib1g-dev", "libbz2-dev", "python-dev", "automake", "libtool", "flex", 
	  "bison", "cmake", "pkg-config", "git", "libssl-dev", "subversion", 
	  "libevent1-dev", "libsasl2-dev", "libldap2-dev", "libdb4.8-dev", "ccache"]
    packages.each do |pkg|
      package pkg
    end

    # Install Maven3 from an external PPA
    apt_repository "maven3" do
      uri 'ppa:natecarlson/maven3'
      components ['main']
      keyserver 'keyserver.ubuntu.com'
      action :add
    end

    package "maven3"

    bash "setup_maven" do
      user 'root'
      code <<-EOH
      ln -s /usr/bin/mvn3 /usr/bin/mvn
      EOH
    end
  end
end

# Python packages
include_recipe "python::pip"

python_pkgs = ["allpairs", "pytest", "pytest-xdist", "paramiko", "texttable", 
	       "prettytable", "sqlparse", "pywebhdfs", "gitpython", "jenkinsapi"]

python_pkgs.each do |pkg|
  python_pip pkg do 
    action :install
  end
end

python_pip "psutil" do
  version "0.7.1"
end

# Setup LZO
bash 'setup_lzo' do
  user 'root'
  code <<-EOH
  if ! test -f /usr/lib/liblzo2.a; then
    ln -s /usr/lib/x86_64-linux-gnu/liblzo2.a /usr/lib/liblzo2.a
  fi
  if ! test -f /usr/lib/liblzo2.so; then
    ln -s /usr/lib/x86_64-linux-gnu/liblzo2.so /usr/lib/liblzo2.so  
  fi
  EOH
end

include_recipe "java::default"
