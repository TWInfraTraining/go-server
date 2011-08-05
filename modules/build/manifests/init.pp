class build::debhelper {
  $build_tools = ["build-essential", "autoconf", "automake", "autotools-dev", "dh-make", "debhelper", "devscripts", "fakeroot", "xutils", "lintian", "pbuilder"]

  package { $build_tools:
    ensure => installed,
  }
}
