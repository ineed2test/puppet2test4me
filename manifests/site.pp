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

# include base classes
hiera_include('classes')
#
#$files = hiera_hash('files', {})
#create_resources('file', $files)
#
#$users = hiera_hash('users', {})
#create_resources('user', $users)
#
#$groups = hiera_hash('groups', {})
#create_resources('group', $groups)


define hiera_users::configure (
  $_users  = hiera_hash("hiera_users::configure::users_${name}", undef),
  $_groups = hiera_hash("hiera_users::configure::groups_${name}", undef),
) {
  if $_groups {
    $groups = keys($_groups)
    hiera_users::configure::groups {
      $groups:
        data => $_groups;
    }
  }

  if $_users {
    $users = keys($_users)
    hiera_users::configure::users {
      $users:
        data => $_users;
    }
  }
}
