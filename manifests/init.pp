#class kundea {
#  class { '::kundea::admins': }
#}

#class { 'hiera_users': }
#include hiera_users
#class kundea {
#  class { '::kundea::admins': }
#  include ::kundea::logging
#}
