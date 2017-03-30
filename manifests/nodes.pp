node "deb02.localdomain" {
      include apache
      package { 'libapache2-modsecurity':
        ensure => present
}
}
