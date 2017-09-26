#

#class kundea::webserver {
#  file { '/home/kundeauser/tomcat/conf/server.xml':
#    content => template('kundea/webserver/server.xml.erb'),
#    owner   => 'kundeauser',
#    group   => 'kundeauser',
#    mode    => '0600',
#  }
#}

#class kundea::webserverfile {
#  file {'/home/kundea/tomcat/conf/server.xml':
#   ### template function
#   ### apache/vhost.conf.erb will load the file <MODULES DIRECTORY>/apache/templates/vhost.conf.erb
#   ###  https://docs.puppet.com/puppet/latest/function.html#template
#    content => template('kundea/server.xml'),
##   ##    source => 'puppet:///modules/kundea/server.xml.erb',
#    owner => 'kundea',
#    group => 'kundea',
#    mode => 'u=rwx,g=rw,o=rw',
#   #   require Definition wird nach der angegebenen Ressource angewendet
#    require => [ Class['tomcat'], File['/home/kundea'] ],
#    ensure => file,
#    }
#}


define kundea::tcserverconf (
  String $text = '',
  $owner = undef,
  $group = undef,
) {
  file {$title:
## template function
### apache/vhost.conf.erb will load the file <MODULES DIRECTORY>/apache/templates/vhost.conf.erb
##  https://docs.puppet.com/puppet/latest/function.html#template
    content => template('kundea/server.xml'),
#    source => 'puppet:///modules/kundea/server.xml.erb',
    owner => $owner,
    group => $group,
    mode => 'u=rwx,g=rw,o=rw',
#    require => File['/home/kundea'],
#   require Definition wird nach der angegebenen Ressource angewendet
#    require => [ Class['tomcat'], File['/home/kundea'] ],
#    ensure => file,
#    tag => [try]
    }
   }