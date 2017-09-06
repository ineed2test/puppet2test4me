#

class kundea::webserver {
  file { '/home/kundeauser/tomcat/conf/server.xml':
    content => template('kundea/webserver/server.xml.erb'),
    owner   => 'kundeauser',
    group   => 'kundeauser',
    mode    => '0600',
  }
}
