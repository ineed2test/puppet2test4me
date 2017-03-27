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

class apache {
$apacheconf = "/etc/apache2"
$mydomainvhost = "partmando"
  file { "server.conf":
    path => "/etc/apache2/sites-available/server.conf",
    content => template('/etc/puppet/environments/staging/files/apache/firstvhost.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }
}
