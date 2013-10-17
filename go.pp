import "java"
import "go"
import "git"
import "cucumber"
import "build"

class { "go::server":
  aws_access_key => "ENTER YOUR AWS ACCESS KEY HERE",
  aws_secret_key => "ENTER YOUR AWS SECRET KEY HERE",
  aws_ami_id => "",
  aws_instance_type => "m1.small",
  go_server_deb_url => "ENTER URL TO DOWNLOAD GO SERVER DEBIAN PACKAGE",
}

class { "go::agent":
  go_agent_deb_url => "ENTER URL TO DOWNLOAD GO AGENT DEBIAN PACKAGE",
}

class { "git":
  authorized_keys => "/home/ubuntu/.ssh/authorized_keys",
}

git::repo { "puppet":
  source => "http://github.com/TWInfraTraining/opencart-puppet.git",
}

git::repo { "opencart":
  source => "http://github.com/TWInfraTraining/opencart.git",
}

git::repo { "build-scripts":
  source => "http://github.com/TWInfraTraining/ec2-build-scripts.git",
}

include cucumber
include build::debhelper
include sun_java_6
