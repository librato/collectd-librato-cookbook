include_recipe 'collectd::client'

opts = {
  'APIToken' => node[:collectd_librato][:api_token],
  'Email' => node[:collectd_librato][:email],
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
end
