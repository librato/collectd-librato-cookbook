#
# Cookbook Name:: collectd-librato
# Recipe:: default
#
# Copyright 2012, Librato
#
# All rights reserved - Do Not Redistribute
#

include_recipe "collectd"
include_recipe "git"

include_recipe "collectd-librato::build"
include_recipe "collectd-librato::install"
