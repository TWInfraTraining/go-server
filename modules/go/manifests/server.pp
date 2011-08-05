import "java"

class go::server($aws_access_key, $aws_secret_key, $go_server_deb_url) {
  package { "unzip":
    ensure => installed,
  }
  
  exec { "download-go-server":
    command => "wget $go_server_deb_url -O /opt/go-server.deb",
    creates => "/opt/go-server.deb",
    path => ["/usr/bin", "/usr/local/bin"],
  }
  
  package { "go-server":
    provider => dpkg,
    ensure => latest,
    source => "/opt/go-server.deb",
    require => [ Package["sun-java6-jre"], Package["unzip"], Exec["download-go-server"] ],
  }

  file { "/etc/go/cruise-config.xml":
    ensure => present,
    content => template("go/etc/go/cruise-config.xml"),
    require => Package["go-server"],
    owner => go,
    group => go,
  }

}
