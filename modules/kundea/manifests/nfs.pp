#
class kundea::nfs(
  Array[String] $exports = [],
  ) {

    ensure_packages(['nfs-kernel-server'], {'ensure' => 'present'})

    exec { 'reloadNfsExports':
      command     => '/usr/sbin/exportfs -r',
      refreshonly => true,
      require     => Package['nfs-kernel-server'],
    }

    $exports.each |$path| {
      file { $path:
        ensure  => 'directory',
      } ->

      file_line { "nfs_${path}":
        path   => '/etc/exports',
        line   => "${path} *(rw,no_subtree_check,async,no_root_squash)",
        notify => Exec['reloadNfsExports'],
      }
    }
}
