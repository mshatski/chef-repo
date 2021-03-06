name 'centos-lamp'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'all_rights'
description 'Installs/Configures centos-lamp'
long_description 'Installs/Configures centos-lamp'
version '0.1.0'

depends 'selinux', '~> 0.9.0'
depends 'firewall', '~> 2.5.2'
depends 'httpd', '~> 0.4.0'
depends 'mysql', '~> 7.2.0'
depends 'mysql2_chef_gem', '~> 1.1.0'
depends 'database', '~> 5.1.2'
