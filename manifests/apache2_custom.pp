class { 'apache':}
#apache::vhost { 'blahexample.com': # define vhost resource
#docroot => '/var/www/html'
#}

# Add vhost File
#class apache::vhosts {
#        
#  if $::osfamily == 'RedHat' {
#    file { '/etc/httpd/conf.d/vhost.conf':
#      ensure    => file,
#      content   => template('apache/vhosts-rh.conf.erb'),
#    }
#  } elsif $::osfamily == 'Debian' {
#    file { "/etc/apache2/sites-available/$servername.conf":
#      ensure  => file,
#      content  => template('/etc/puppet/environment/staging/files/apache/firstvhost.conf.erb'),
#    }
#  } else {
#    print "This is not a supported distro."
# }
#        
#}
$apacheconf = "/etc/apache2"
class apache {
  file { $apacheconf/sites-available/servername.conf:
    content => template('/etc/puppet/environments/staging/files/apache/firstvhost.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }
}
