#class { '::apache::mod::jk':
#  ip => '192.168.2.15',
#  workers_file => '/tmp/workers.properties',
#  mount_file => '/tmp/uriworkermap.properties',
#  shm_file => '/tmp/jk.shm',
#  shm_size => '50M',
#}