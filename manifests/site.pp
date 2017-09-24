file {'/tmp/example-ip':                                            # resource type file and filename
  ensure  => present,                                               # make sure it exists
  mode    => '0755',                                                  # file permissions
  content => "Here is my Public IP Address: ${ipaddress_eth0}.\n",  # note the ipaddress_eth0 fact
}

#node 'deb02.localdomain' {
#  class { 'apache': }             # use apache module
#  apache::vhost { 'example.com':  # define vhost resource
#    port    => '80',
#    docroot => '/var/www/html'
#  }
#}


#test variable set in hiera file
#$schoko = 'lekker'
$schoko = hiera('schoko','empty')
notify{"It's time for: ${schoko}": }

#$globalgrouphieradata = hiera('globalgrouphieradata','empty')
#notify{"The value is: ${globalgrouphieradata}": }

$globalgrouphieradatalb0 = hiera('globalgrouphieradatalb0','empty')
notify{"The value is: ${globalgrouphieradatalb0}": }

$globalgrouphieradataweb0 = hiera('globalgrouphieradataweb0','empty')
notify{"The value is: ${globalgrouphieradataweb0}": }

# include base classes
hiera_include('classes')

$files = hiera_hash('files', {})
create_resources('file', $files)

$users = hiera_hash('users', {})
create_resources('user', $users)

$groups = hiera_hash('groups', {})
create_resources('group', $groups)

$ha_frontend = hiera_hash('ha_frontend', {}) 
create_resources('ha_frontend', $ha_frontend)

#test new hiera hash for haproxy
#
#$ha_global_options = hiera_hash('haproxy::global_options',{})
#create_resources('haproxy::global_options',$ha_global_options)
#
#$ha_frontend = hiera_hash('haproxy::frontend',{})
#create_resources('haproxy::frontend',$ha_frontend)
#
#$ha_backend = hiera_hash('haproxy::backend',{})
#create_resources('haproxy::backend',$ha_backend)
#create_resources(haproxy::frontend, hiera_hash('profile::haproxy::frontends'))

# haproxy
$haproxy_frontend = hiera('haproxy::frontend', {})
$haproxy_backend = hiera('haproxy::backend', {})
$haproxy_balancemember = hiera('haproxy::balancermember', {})
$haproxy_listen = hiera('haproxy::listen', {})
#$sslmycertfilemanagement = hiera('mycertfilemanagement::certm', {})

create_resources('haproxy::frontend', $haproxy_frontend)
create_resources('haproxy::backend', $haproxy_backend)
create_resources('haproxy::balancermember', $haproxy_balancemember)
create_resources('haproxy::listen', $haproxy_listen)
#create_resources('mycertfilemanagement::certm', $sslmycertfilemanagement)

# apache
$apache_vhost = hiera('apache::vhost', {})
create_resources('apache::vhost', $apache_vhost)

$apache_mod_jk = hiera('apache::mod::jk', {})
create_resources('apache::mod::jk', $apache_mod_jk)

#tomcat
$tomcat_install = hiera('tomcat_install', {})
create_resources('tomcat::install', $tomcat_install)

$tomcat_instance = hiera('tomcat_instance', {})
create_resources('tomcat::instance', $tomcat_instance)

$tomcat_config_server = hiera('tomcat_config_server', {})
create_resources('tomcat::config::server', $tomcat_config_server)

$tomcat_config_server_connector = hiera('tomcat_config_server_connector', {})
create_resources('tomcat::config::server::connector', $tomcat_config_server_connector)

$tomcat_config_server_tomcat_users =  hiera('tomcat_config_server_tomcat_users', {})
create_resources('tomcat::config::server::tomcat_users', $tomcat_config_server_tomcat_users)

#package
$packages = hiera('packages', {})
create_resources('package', $packages)

# host /etc/hosts
$hosts = hiera('hosts', {})
create_resources('host', $hosts)

#service
$services = hiera('services', {})
create_resources('service', $services)

#exec commands
$execs = hiera('execs', {})
create_resources('exec', $execs)

#stdlib file_line
#$file_lines = hiera('file_lines', {})
#create_resources('file_line', $file_lines)

#$apache_mod_jk = hiera('apache::mod', {})
#create_resources('apache::mod', $apache_mod_jk)

#ordering with collectors

#package <| |> -> file['/home/kundea'] <| |> -> tomcat <| |> -> file['/home/kundea/tomcat/conf/server.xml']
Packages <| |> -> Files <| |>