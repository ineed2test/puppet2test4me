     group { 'web':
  			  ensure => 'present',
  			  gid    => '1502',
     }

user { 'jargyle':
 			  ensure           => 'present',
       gid              => '1502',
       home             => '/home/jargyle',
       password         => '!!',
       password_max_age => '99999',
       password_min_age => '0',
       shell            => '/bin/bash',
       uid              => '1501',
     }
