#

class kundea::logging(
  $server = false,
  $mounts = {},
  ) {

  if $server {
    ensure_packages(['nfs-kernel-server'], {'ensure' => 'present'})

    exec { 'reloadNfsExports':
      command     => '/usr/sbin/exportfs -r',
      refreshonly => true,
      require     => Package['nfs-kernel-server'],
    }

    File_line <<| tag == "env-${::environment}" and tag == 'logging' |>>
    File <<| tag == "env-${::environment}" and tag == 'logging' |>>
  }

  if !$server {
    create_resources('logserver_mount',$mounts)
    @@file { "/srv/syslog/${::fqdn}/":
      ensure  => 'directory',
      require => File['/srv/syslog/'],
    }
  }
}
