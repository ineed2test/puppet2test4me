#

define kundea::logserver_mount(
  $path,
  ) {

  $ip = pick(hiera('override_ipaddress', $::ipaddress_eth0, $::ipaddress))

  @@file_line { "${::fqdn}_${name}_exportLogDirectory":
    path    => '/etc/exports',
    line    => "/srv/syslog/${::fqdn}/${name} ${ip}(rw,no_subtree_check,async,no_root_squash)",
    notify  => Exec['reloadNfsExports'],
    require => File["${::fqdn}_${name}_LogDirectory"],
  }

  @@file { "${::fqdn}_${name}_LogDirectory":
    ensure  => 'directory',
    path    => "/srv/syslog/${::fqdn}/${name}",
    require => File["/srv/syslog/${::fqdn}/"],
  }

  ensure_resource('file', $path, {ensure => 'directory',})

  mount { $path:
    ensure  => 'mounted',
    device  => "logger00.kundeauser.intern:/srv/syslog/${::fqdn}/${name}",
    fstype  => 'nfs',
    atboot  => true,
    options => '_netdev,auto,nolock,nocto,actimeo=3600',
  }
}
