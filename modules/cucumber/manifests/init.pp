class cucumber::dependencies {
  $deps = [ 'libruby', 'libxslt1-dev', 'libxml2-dev', 'rubygems' ]
  package { $deps:
    ensure => installed,
  }
}

class cucumber {
  include cucumber::dependencies

  $gem_packages = [ "cucumber", "mechanize", "webrat", "rspec", "rspec-expectations" ]
  
  package { $gem_packages:
    ensure => installed,
    provider => gem,
    require => Class["cucumber::dependencies"],
  }

  file { "/usr/local/bin/cucumber":
    ensure => link,
    target => "/var/lib/gems/1.8/bin/cucumber",
    require => Package['cucumber'],
  }
}
