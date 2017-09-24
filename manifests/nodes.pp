## define nodes with associated modules and distro packages
#node default {
#       include mycertfilemanagement
#}

#node 'deb03.localdomain' {
#node default {
#      class { 'mycertfilemanagement': }
#       include mycertfilemanagement::certm['title1']
#       include mycertfilemanagement
#      include apache
#      class { 'mymotd': }
#      class {'::accounts':}
#      class { 'hiera_users': }

#      include git
#      include apt     !!! notworking together with class 'apt'
      
#class {'apt':
#update => { 'frequency' => 'always' }
#}

#$packages = ["libapache2-modsecurity","git"]
#package {
#$packages: ensure => installed,
#}

#class git{
#    include git::install
#}
#
#class git::install{
#    package { 'git:':
#        ensure => present
#    }
#}


#}
node default {}
node 'deb03.localdomain' {
  file {'/home/kundea/tomcat/conf/server.xml':
#    content => template('kundea/files/server.xml.erb'),
    source => 'puppet:///modules/kundea/server.xml'
    owner => 'kundea',
    group => 'kundea',
    mode => 'u=rwx,g=rw,o=rw',
    }
  }