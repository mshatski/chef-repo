#
# Cookbook Name:: centos-lamp
# Recipe:: database
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#MySQL client configuration.
mysql_client 'default' do
  action :create
end

#MySQL service configuration.
mysql_service 'default' do
  initial_root_password node['centos-lamp']['database']['root_password']
  action [:create, :start]
end

#Install the mysql2 Ruby gem.
mysql2_chef_gem 'default' do
  action :install
end

# Create the database instance.
mysql_database node['centos-lamp']['database']['dbname'] do
  connection(
    :host => node['centos-lamp']['database']['host'],
    :username => node['centos-lamp']['database']['root_username'],
    :password => node['centos-lamp']['database']['root_password']
  )
  action :create
end

# Add a database user.
mysql_database_user node['centos-lamp']['database']['admin_username'] do
  connection(
    :host => node['centos-lamp']['database']['host'],
    :username => node['centos-lamp']['database']['root_username'],
    :password => node['centos-lamp']['database']['root_password']
  )
  password node['centos-lamp']['database']['admin_password']
  database_name node['centos-lamp']['database']['dbname']
  host node['centos-lamp']['database']['host']
  action [:create, :grant]
end

# Create a path to the SQL file in the Chef cache.
create_tables_script_path = File.join(Chef::Config[:file_cache_path], 'create-tables.sql')

# Write the SQL script to the filesystem.
cookbook_file create_tables_script_path do
  source 'create-tables.sql'
  owner 'root'
  group 'root'
  mode '0600'
end

# Seed the database with a table and test data.
execute "initialize #{node['centos-lamp']['database']['dbname']} database" do
  command "mysql -h #{node['centos-lamp']['database']['host']} -u #{node['centos-lamp']['database']['admin_username']} -p#{node['centos-lamp']['database']['admin_password']} -D #{node['centos-lamp']['database']['dbname']} < #{create_tables_script_path}"
  not_if  "mysql -h #{node['centos-lamp']['database']['host']} -u #{node['centos-lamp']['database']['admin_username']} -p#{node['centos-lamp']['database']['admin_password']} -D #{node['centos-lamp']['database']['dbname']} -e 'describe customers;'"
end