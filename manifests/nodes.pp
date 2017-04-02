## define nodes with associated modules and distro packages

node "deb02.localdomain" {
      include apache
#      include apt     !!! notworking together with class 'apt'
      
class {'apt':
update => { 'frequency' => 'always' }
}

$packages = ["libapache2-modsecurity","git"]
package {
$packages: ensure => installed,
}


}
