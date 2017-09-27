class kundea::webserver {
  file { '/home/kundea/tomcat/conf/server.xml':
    content => template('kundea/server.xml'),
    owner   => 'kundea',
    group   => 'kundea',
    mode    => 'u=rwx,g=rw,o=rw',
  }
}