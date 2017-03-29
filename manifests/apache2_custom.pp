#class { 'apache':}
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
$mydomainvhost = "partmando"



class apache::vhosts {
  file { "server.conf":
    path => "/etc/apache2/sites-available/server.conf",
    content => template('/etc/puppet/environments/staging/files/apache/firstvhost.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }
  }
  
# set a symlink to vhost in /etc/sites-enable
  file { '/etc/apache2/sites-enabled/server.conf':
  ensure => 'link',
  target => '/etc/apache2/sites-available/server.conf',
#  ensure => '/etc/apache2/sites-available/server.conf',
}


# delete a wrong named directory
tidy { 'site-available':
  path => "/etc/apache2/site-available"
  }
