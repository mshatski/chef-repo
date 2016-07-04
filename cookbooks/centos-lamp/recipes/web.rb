#
# Cookbook Name:: centos-lamp
# Recipe:: web
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Install Apache and start the service.
httpd_service 'tcook' do
  mpm 'prefork'
  action [:create, :start]
end

# Add the site configuration.
httpd_config 'tcook' do
  instance 'tcook'
  source 'tcook.conf.erb'
  notifies :restart, 'httpd_service[tcook]'
end

# Create the document root directory.
directory node['centos-lamp']['document_root'] do
  recursive true
end

# Write the home page.
template "#{node['centos-lamp']['document_root']}/index.php" do
  source 'index.php.erb'
  mode '0644'
  owner node['centos-lamp']['user']
  group node['centos-lamp']['group']
end

# Install the mod_php Apache module.
httpd_module 'php' do
  instance 'tcook'
end

# Install php-mysql.
package 'php-mysql' do
  action :install
  notifies :restart, 'httpd_service[tcook]'
end