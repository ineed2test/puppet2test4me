# Installation modsecurity2
node deb02.localdomain {
    package { 'libapache2-modsecurity':
        ensure => present
    }
    }
