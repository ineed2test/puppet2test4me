#class kundea {
#  class { '::kundea::admins': }
#}

#class { 'hiera_users': }
#include hiera_users
class datingcafebase {
  class { '::datingcafebase::admins': }
  include ::datingcafebase::logging
}
