class kundea {
  class { '::kundea::admins': }
  include ::kundea::logging
  include ::kundea::tcserverconf
}
