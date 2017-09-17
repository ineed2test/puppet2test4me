class { '::apache::mod::jk':
  ip => '192.168.2.15',
  workers_file => 'conf/workers.properties',
  mount_file => 'conf/uriworkermap.properties',
  shm_file => 'run/jk.shm',
  shm_size => '50M',
  workers_file_content => {
      worker.list = some_name
  },
}