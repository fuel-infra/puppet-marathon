class marathon::startup(
  $startup_manage         = $marathon::params::startup_manage,
  $launcher_manage        = $marathon::params::launcher_manage,
  $launcher_path          = $marathon::params::launcher_path,
  $jar_file_path          = $marathon::params::jar_file_path,
  $service_name           = $marathon::params::service_name,
) inherits ::marathon::params {
  validate_string($service_name)
  validate_absolute_path($launcher_path)
  validate_bool($startup_manage)
  validate_bool($launcher_manage)

  if $jar_file_path {
    validate_absolute_path($jar_file_path)
  }

  File {
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  if $startup_manage {

    if $::operatingsystem == 'Ubuntu' {

      file { 'marathon_upstart_file' :
        path    => "/etc/init/${service_name}.conf",
        content => template('marathon/upstart.conf.erb'),
      }

      file { 'marathon_init.d_wrapper' :
        ensure => 'symlink',
        path   => "/etc/init.d/${service_name}",
        target => '/lib/init/upstart-job',
      }

      File['marathon_upstart_file'] ~>
      Service <| title == 'marathon' |>

      File['marathon_init.d_wrapper'] ~>
      Service <| title == 'marathon' |>

    }

  }

  if $launcher_manage {

    file { 'marathon_launcher_file' :
      path    => $launcher_path,
      content => template('marathon/launcher.sh.erb'),
      mode    => '0755',
    }

    File['marathon_launcher_file'] ~>
    Service <| title == 'marathon' |>

  }

}
