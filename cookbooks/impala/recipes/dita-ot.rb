# Cookbook Name:: impala
# Recipe:: dita-ot
#
# Copyright 2016, Cloudera Inc.


bash 'install_dita-ot' do
  user node['impala_dev']['username']
  code <<-EOF
  UNZIP_LOCATION=$(mktemp -d)
  cd "${UNZIP_LOCATION}"
  wget https://github.com/dita-ot/dita-ot/releases/download/2.3.3/dita-ot-2.3.3.zip
  unzip dita-ot-2.3.3.zip
  sudo cp -r dita-ot-2.3.3 /opt/
  cd /
  rm -rf "${UNZIP_LOCATION}"
  echo 'PATH=/opt/dita-ot-2.3.3/bin:"${PATH}"' >> /home/#{node['impala_dev']['username']}/.bashrc
  EOF
end
