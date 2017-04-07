#

class datingcafebase::admins {
  hiera_hash('admins').each |$username,$props| {
    user { $username:
      uid      => pick_default($props['uid'],false),
      password => pick($props['uid'],'!'),
      home     => "/home/${username}/",
      shell    => pick($props['shell'],'/bin/bash')
    } ->
    file { "/home/${username}/":
      ensure => 'directory',
      owner  => $username,
      mode   => '0755',
    } ->
    file { "/home/${username}/.ssh":
      ensure => 'directory',
      owner  => $username,
      mode   => '0700',
    }

    $props['sshkeys'].each |$index,$sshkey| {
      ssh_authorized_key { "${username}_${index}":
        user    => $username,
        type    => 'ssh-rsa',
        key     => $sshkey,
        require => File["/home/${username}/.ssh"],
      }
      ssh_authorized_key { "${username}_${index} on root":
        user => 'root',
        type => 'ssh-rsa',
        key  => $sshkey,
      }
    }

    sudo::conf { "sudo_Admin_${username}":
      ensure  => present,
      content => "${username} ALL=NOPASSWD: ALL",
      require => User[$username],
    }
  }
}
