#
# Cookbook Name:: impala
# Recipe:: llvm
#
# Copyright 2015, Cloudera Inc.
#
# All rights reserved - Do Not Redistribute
#
# Install LLVM
Chef::Log.info("Building and installing llvm. This can take a long time...")

bash "install_llvm" do
  user 'root'
  code <<-EOH
  if ! test -f /llvm-3.3.src.tar.gz; then 
    wget http://llvm.org/releases/3.3/llvm-3.3.src.tar.gz
    tar xvf llvm-3.3.src.tar.gz
    cd llvm-3.3.src/tools/
    svn co http://llvm.org/svn/llvm-project/cfe/tags/RELEASE_33/final/ clang
    cd ../projects/
    svn co http://llvm.org/svn/llvm-project/compiler-rt/tags/RELEASE_33/final
    cd ..
    ./configure --with-pic
    make -j4 REQUIRES_RTTI=1
    make install 
  fi
  EOH
end
