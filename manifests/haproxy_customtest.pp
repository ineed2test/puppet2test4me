#  haproxy::frontend { 'puppet00':
#    ipaddress    => $::ipaddress,
#    ports        => '18140',
#    mode         => 'tcp',
#    bind_options => 'accept-proxy',
#    options      => {
#      'option'   => [
#        'tcplog',
#        'accept-invalid-http-request',
#      ],
#      'timeout client' => '30',
#      'balance'    => 'roundrobin'
#    },
#  }
node 'deb3.localdomain' {
host { 'deb03.localdomain':
  ensure       => 'present',
  host_aliases => ['deb03'],
  ip           => '192.168.1.10',
  target       => '/etc/hosts',
}
}