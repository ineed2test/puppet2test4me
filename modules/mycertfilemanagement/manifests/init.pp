# funktionert mit hiera_include('classes') und einer create_resource Funktion die innerhalb der Klasse als Parameter geladen wird
# create a class mycertfilemanagement and load the hash of resource mycertfilemanagement::certm ships from the create_resource funktion as parameter $certificates 
# create a directory /etc/ssl/mycerts
# copy a cert file /modules/mycertfilemanagement/files/kundea.de.combined.withkey.crt to /etc/ssl/mycerts
# create a file /etc/ssl/mycerts/zz_DIRECTORY_MANAGED_BY_PUPPET
# !!! Laut Puppet Doku muss ein defined type declared werden und es muss ein title ($name u. $title) mit angegeben werden. Das übernimmt aber hiera mit 
# mycertfilemanagement::certificates:
#   'title3':
#     combinedwithkey: 'kundea.de.combined.withkey.crt'
# !!!
class mycertfilemanagement ( $certificates = {}) {
create_resources ('mycertfilemanagement::certm', $certificates)}

  define mycertfilemanagement::certm(
	String $combinedwithkey,
	String $anotherkey,
	String $anotherkeyitest
){

  file {
    '/etc/ssl/mycerts':
      ensure  => 'directory',
      purge   => true,
      recurse => true,
      force   => true;
      '/etc/ssl/mycerts/zz_DIRECTORY_MANAGED_BY_PUPPET':
      ensure  => present,
      before => Service['haproxy'],
      content => '

    #######################################################################\r\n
    ##                                                                   ##\r\n
    ## This directory is managed by puppet! All changes will be deleted! ##\r\n
    ##                                                                   ##\r\n
    #######################################################################\r\n
    ';

}

    package { 'openssl':
      provider => apt,
      ensure => 'installed',
      }

notify{"It's time for: ${combinedwithkey}": }
notify{"the name is: ${name}": }
notify{"the title is: ${title}": }

    if ($combinedwithkey) {
    file {
      "/etc/ssl/mycerts/${combinedwithkey}":
        ensure  => $ensure,
        source  => "puppet:///modules/mycertfilemanagement/${combinedwithkey}",
	before => Service['haproxy']
#        source  => "puppet:///etc/puppet/environments/test20170816/modules/mycertfilemanagement/files/${combinedwithkey}"
#        !!! not okay source  => "puppet:///modules/mycertfilemanagement/files/${combinedwithkey}"
    }
   }
     if ($anotherkey) {
       file {
         "/etc/ssl/mycerts/${anotherkey}":
           ensure  => $ensure,
           source  => "puppet:///modules/mycertfilemanagement/${anotherkey}",
	   before => Service['haproxy']
    }
   }

# test when file $$anotherkeyitest not exist
# not working
#       exec { "check_presence":
#	    command => "/bin/true",
#	    onlyif => '/usr/bin/test -e puppet:///modules/mycertfilemanagement/${anotherkeyitest}',
#}
#       file {
#         "/etc/ssl/mycerts/${anotherkeyitest}":
#           ensure  => file,
#           source  => "puppet:///modules/mycertfilemanagement/${anotherkeyitest}",
#	   require => Exec["check_presence"]
#    }
# it work's
    $a = file('/etc/puppet/environments/test20170816/modules/mycertfilemanagement/files/noexist.crt','/dev/null')
#    $a = file('puppet:////modules/mycertfilemanagement/files/noexist.crt}','/dev/null')
    if($a != '') {
       file {
         "/etc/ssl/mycerts/${anotherkeyitest}":
#           source  => "puppet:///modules/mycertfilemanagement/${anotherkeyitest}",
            content => $a,
	    before => Service['haproxy']
    }        
   }

  file {
    '/var/loadbalancer_maintenance/':
      ensure  => 'directory',
      purge   => true,
      recurse => true,
      before => Service['haproxy'],
     }

    file {
      "/var/loadbalancer_maintenance/index.html":
        ensure  => $ensure,
        source  => "puppet:///modules/mycertfilemanagement/index.html",
}
}
#	mycertfilemanagement::certm { 'title1':
#		combinedwithkey => 'kundea.de.combined.withkey.crt', } 

