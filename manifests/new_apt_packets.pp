# Installation modsecurity2
node default {
    package { 'libapache2-modsecurity':
        ensure => present
    }
