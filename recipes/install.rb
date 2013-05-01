include_recipe 'collectd::client'
ver = node[:collectd_librato][:version]

opts = {
  'APIToken' => node[:collectd_librato][:api_token],
  'Email' => node[:collectd_librato][:email]
}

if node[:collectd_librato][:api]
  opts['Api'] = node[:collectd_librato][:api]
end

# Install plugin
collectd_plugin 'collectd-librato' do
  path "/opt/collectd-librato-#{ver}/lib"
  type 'python'
  options(opts)
end
