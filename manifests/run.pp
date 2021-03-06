define docker::run($image, $command, $running = true) {

  validate_re($image, '^[\S]*$')
  validate_re($title, '^[\S]*$')
  validate_string($command)
  validate_bool($running)

  file { "/etc/init/docker-${title}.conf":
    ensure  => present,
    content => template('docker/etc/init/docker-run.conf.erb')
  }

  service { "docker-${title}":
    ensure     => $running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    provider   => upstart,
    require    => File["/etc/init/docker-${title}.conf"],
  }

}
