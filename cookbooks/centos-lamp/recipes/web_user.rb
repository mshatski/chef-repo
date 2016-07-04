#
# Cookbook Name:: centos-lamp
# Recipe:: web_user
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

group node['centos-lamp']['group']

user node['centos-lamp']['user'] do
  group node['centos-lamp']['group']
  system true
  shell '/bin/bash'
end