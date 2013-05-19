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

execute 'install_collectd_librato' do
  cwd "/opt/src/collectd-librato-#{node[:collectd_librato][:version]}"
  command 'make install'
  creates "/opt/collectd-librato-#{node[:collectd_librato][:version]}"
  not_if { File.exist?("/opt/collectd-librato-#{node[:collectd_librato][:version]}") }
  action :nothing
end

git "/opt/src/collectd-librato-#{node[:collectd_librato][:version]}" do
  repository node[:collectd_librato][:repo]
  reference "v#{node[:collectd_librato][:version]}"
  action :sync
  notifies :run, "execute[install_collectd_librato]", :immediately
end

include_recipe 'collectd::client'

unless node[:collectd_librato][:APIToken]
  log 'collectd_librato_APIToken' do
    level :error
    message 'The node[:collectd_librato][:APIToken] attribute has not been set.  The collectd_librato plugin will not work correctly.'
  end
end

unless node[:collectd_librato][:Email]
  log 'collectd_librato_Email' do
    level :error
    message 'The node[:collectd_librato][:Email] attribute has not been set.  The collectd_librato plugin will not work correctly.'
  end
end

opts = {
  'APIToken' => node[:collectd_librato][:APIToken],
  'Email' => node[:collectd_librato][:Email],
  :paths => ["/opt/collectd-librato-#{node[:collectd_librato][:version]}/lib"]
}

if node[:collectd_librato][:api]
  opts['Api'] = node[:collectd_librato][:api]
end

# Install plugin
collectd_plugin 'collectd-librato' do
  template 'collectd-librato.conf.erb'
  type 'python'
  options(opts)
  not_if { node[:collectd_librato][:APIToken].nil? }
  not_if { node[:collectd_librato][:Email].nil? }
end
