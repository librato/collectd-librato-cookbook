Description
===========

Chef cookbook that installs and configures the [Librato Metrics
Collectd Plugin](https://github.com/librato/collectd-librato).

Requirements
============

 * [collectd cookbook](https://github.com/librato/collectd-cookbook)

Attributes
==========

 * `node[:collectd_librato][:version]` - Version of Librato Collectd
   plugin to install. Tag must exist. (optional, defaults to latest)
 * `node[:collectd_librato][:email]` - Librato Metrics Email
 * `node[:collectd_librato][:api_token]` - Librato Metrics API Token

Usage
=====

After setting the above attributes (whether through chef-server or by just including them in your recipe), include the `collectd` recipe (see Requirements) and `collectd-librato` recipe to your recipe or runlist:

```ruby
# recipe
include_recipe "collectd"
include_recipe "collectd-librato"
# runlist
recipe[collectd]
recipe[collectd-librato]
```

Verifcation
===========
If everything went well, there should be a file at `/etc/collectd/plugins/python.conf` which configures the librato python plugin with your credentials.
