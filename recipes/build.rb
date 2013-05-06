#
# Cookbook Name:: collectd-librato
# Recipe:: default
#
# Copyright 2012, Librato
#
# All rights reserved - Do Not Redistribute
#

include_recipe('python::package')

directory '/opt/src'

git "/opt/src/collectd-librato-#{node[:collectd_librato][:version]}" do
  repository node[:collectd_librato][:repo]
  reference "v#{node[:collectd_librato][:version]}"
  action :sync
end

bash 'install_collectd_librato' do
  cwd "/opt/src/collectd-librato-#{node[:collectd_librato][:version]}"
  code <<EOH
make install
EOH
  not_if { File.exist?("/opt/collectd-librato-#{node[:collectd_librato][:version]}") }
end
