#
# Cookbook Name:: collectd-librato
# Recipe:: default
#
# Copyright 2012, Librato
#
# All rights reserved - Do Not Redistribute
#

include_recipe "git"

repo = node[:collectd_librato][:repo]
ver = node[:collectd_librato][:version]

package "libpython2.7"
package "make"

directory "/opt/src"

git "/opt/src/collectd-librato-#{ver}" do
  repository repo
  reference "v#{ver}"
  action :sync
end

bash "install_collectd_librato" do
  cwd "/opt/src/collectd-librato-#{ver}"
  code <<EOH
make install
EOH
  not_if { File.exist?("/opt/collectd-librato-#{ver}") }
end
