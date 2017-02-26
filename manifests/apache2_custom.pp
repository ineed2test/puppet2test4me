class { 'apache':}
#apache::vhost { 'blahexample.com': # define vhost resource
#docroot => '/var/www/html'
#}

# Add vhost File
class apache::vhosts {
        
  if $::osfamily == 'RedHat' {
    file { '/etc/httpd/conf.d/vhost.conf':
      ensure    => file,
      content   => template('apache/vhosts-rh.conf.erb'),
    }
  } elsif $::osfamily == 'Debian' {
    file { "/etc/apache2/sites-available/$servername.conf":
      ensure  => file,
      content  => template('files/apache/firstvhost.conf.erb'),
    }
  } else {
    print "This is not a supported distro."
  }
        
}

