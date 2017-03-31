class { 'apache': }
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

# apache module / comment out to enable module / extra 'a2enmod' command need to link ../mod-enabled/<mod>.conf 
apache::mod { 'ssl': }
apache::mod { 'security2': }

# modsecurity installation
# 1. copy .erb template
    file { '/etc/apache2/mods-available/security2.conf':
    ensure => 'file',
    content => template('/etc/puppet/environments/staging/files/apache/security2.conf.erb'),
    owner   => 'root',
    group   => 'adm',
    mode    => '0755',
  }


# create vhost File from template
    file { '/etc/apache2/sites-available/server.conf':
    ensure => 'file',
    content => template('/etc/puppet/environments/staging/files/apache/firstvhost.conf.erb'),
    owner   => 'root',
    group   => 'adm',
    mode    => '0777',
  }
  
  
# set a symlink to vhost in /etc/sites-enable
  file { '/etc/apache2/sites-enabled/server.conf':
  ensure => 'link',
  target => '/etc/apache2/sites-available/server.conf',
#  ensure => '/etc/apache2/sites-available/server.conf',
}

# create logfile directory
file { "/var/log/${::fqdn}":
ensure => 'directory',
owner   => 'root',
group   => 'adm',
mode    => '0700',
  }
  
  

# delete a wrong named directory
tidy { 'site-available':
  path => "/etc/apache2/site-available"
  }
