node "deb02.localdomain" {
      include apache
      include apt
      
class { 'apt':
update => { 'frequency' => 'always' },
}

$packages = ["libapache2-modsecurity"]
package {
$packages: ensure => installed,
}
}
