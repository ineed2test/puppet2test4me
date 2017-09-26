class kundea {
  class { '::kundea::admins': }
  include ::kundea::logging
  kundea::tcserverconf
}
