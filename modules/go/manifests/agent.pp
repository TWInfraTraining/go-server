import "java"

class go::agent($go_agent_deb_url) {
  exec { "download-go-agent":
    command => "wget $go_agent_deb_url -O /opt/go-agent.deb",
    creates => "/opt/go-agent.deb",
    path => ["/usr/bin", "/usr/local/bin"],
  }

  package { "go-agent":
    provider => dpkg,
    ensure => latest,
    source => "/opt/go-agent.deb",
    require => [ Exec["download-go-agent"], Package["sun-java6-jdk" ] ],
  }

}
