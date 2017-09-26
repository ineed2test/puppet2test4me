class kundea {
  class { '::kundea::admins': }
  kundea::tcserverconf { 'test':
      text => 'alltest',
    }
}
