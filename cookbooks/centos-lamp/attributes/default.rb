def random_password
  require 'securerandom'
  SecureRandom.base64
end

#firewall defaults
default['firewall']['allow_ssh'] = true
default['firewall']['firewalld']['permanent'] = true
default['centos-lamp']['open_ports'] = [80, 443]
#web_user and web defaults
default['centos-lamp']['user'] = 'web_admin'
default['centos-lamp']['group'] = 'web_admin'
default['centos-lamp']['document_root'] = '/var/www/tcook/public_html'
#generate random passwords
normal_unless['centos-lamp']['database']['root_password'] = random_password
normal_unless['centos-lamp']['database']['admin_password'] = random_password
#database defaults
default['centos-lamp']['database']['dbname'] = 'tcook'
default['centos-lamp']['database']['host'] = '127.0.0.1'
default['centos-lamp']['database']['root_username'] = 'root'
default['centos-lamp']['database']['admin_username'] = 'db_admin'