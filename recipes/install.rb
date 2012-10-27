include_recipe "collectd"

ver = node[:collectd_librato][:version]

# Install plugin
collectd_python_plugin "collectd-librato" do
  path "/opt/collectd-librato-#{ver}/lib"
  opts = {
    "APIToken" => node[:collectd_librato][:api_token],
    "Email" => node[:collectd_librato][:email]
  }

  if node[:collectd_librato][:api]
    opts["Api"] = node[:collectd_librato][:api]
  end
  options(opts)
end
