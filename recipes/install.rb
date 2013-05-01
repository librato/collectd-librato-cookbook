include_recipe 'collectd::client'
ver = node[:collectd_librato][:version]

opts = {
  'APIToken' => node[:collectd_librato][:api_token],
  'Email' => node[:collectd_librato][:email],
  'paths' => ["/opt/collectd-librato-#{ver}/lib"]
}

if node[:collectd_librato][:api]
  opts['Api'] = node[:collectd_librato][:api]
end

# Install plugin
collectd_plugin 'collectd-librato' do
  type 'python'
  options(opts)
end
