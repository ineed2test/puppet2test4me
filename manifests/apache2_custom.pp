class { 'apache':}
apache::vhost { 'blahexample.com': # define vhost resource
docroot => '/var/www/html'
}
