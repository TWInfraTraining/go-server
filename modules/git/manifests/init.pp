$git_home = "/var/git"

class git( $authorized_keys ) {
  define repo($source = "") {
    $git_repo = "$git_home/$name.git"

    file { "$git_repo":
      ensure => directory,
      owner => git,
      require => User["git"],
    }

    if $source {
      $create_command = "/usr/bin/git clone --bare $source ."
    } else {
      $create_command = "/usr/bin/git init --bare"
    }

    exec { "$name git repo":
      cwd => "$git_repo",
      user => "git",
      command => $create_command,
      creates => "$git_repo/HEAD",
      require => [File["$git_repo"], Package["git"], User["git"]],
    }
  }

  user { "git":
    ensure => present,
    home => $git_home,
    shell => "/usr/bin/git-shell",
    password => '!$6$MZ2tgKH8$SFRUaTY7N8V9j99wLpNM.S7lia0owmlIpVa1bEG4uqM2vpAJQd2zJZgGQ8ob8opYzhgb7xCbhqehi4ncD6uwm/',
  }
  
  file {"$git_home":
    ensure => directory, owner => git,
    require => User["git"]
  }

  file {"$git_home/.ssh":
    ensure => directory,
    owner => git,
    mode => "700",
  }

  file {"$git_home/.ssh/authorized_keys":
    ensure => present,
    mode => "600",
    owner => git,
    content => file("$authorized_keys"),
  }

  package { "git":
    ensure => installed,
  }
}
