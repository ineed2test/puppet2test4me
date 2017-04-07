class mymotd {
 
  package { 'figlet':
    ensure => 'installed'
  }
  
  file { '/etc/motd':
    ensure => 'present',
    source => 'puppet:///modules/mymotd/mymotd',
    owner  => 'root',
    group  => 'root',
    mode   => '0755'
  }
}
