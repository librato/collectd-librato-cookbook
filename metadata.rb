name 'collectd-librato'
maintainer       'Librato, Inc.'
maintainer_email 'mike@librato.com'
license          'Apache 2.0'
description      "Installs/Configures Librato's Collectd Plugin"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.4'

depends 'collectd'
depends 'python'

recipe 'collectd-librato', "Installs Librato's Collectd Plugin"
recipe 'collectd-librato::build', 'Just build plugin'
recipe 'collectd-librato::install', 'Just install plugin'
