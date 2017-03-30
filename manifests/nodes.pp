node "deb02.localdomain" {
      include apache
      
class { 'apt':
always_apt_update => true,
}
exec { 'apt-get-update':
command     => '/usr/bin/apt-get update',
refreshonly => true,
}

$packages = ["libapache2-modsecurity"]
package {
$packages: ensure => installed,
require    => Exec['apt-get-update'],
}
}
