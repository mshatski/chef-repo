#
# Cookbook Name:: centos-lamp
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'selinux::permissive'
include_recipe 'centos-lamp::firewall'
include_recipe 'centos-lamp::web_user'
include_recipe 'centos-lamp::web'
include_recipe 'nginx::default'
include_recipe 'centos-lamp::database'
