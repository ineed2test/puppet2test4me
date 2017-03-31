## define nodes with associated modules and distro packages

node "deb02.localdomain" {
      include apache
      include apt
      
update => { 'frequency' => 'always' }

$packages = ["libapache2-modsecurity"]
package {
$packages: ensure => installed,
}
}
