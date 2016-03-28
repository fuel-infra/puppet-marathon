class marathon::java (
  $java_manage   = $marathon::params::java_manage,
  $java_package  = $marathon::params::java_package,
  $java_ensure   = $marathon::params::java_ensure,
  $java_provider = $marathon::params::java_provider,
) inherits ::marathon::params {
  validate_string($java_ensure)
  validate_string($java_package)
  validate_bool($java_manage)

  if $java_provider {
    validate_string($java_provider)
  }

  if $java_manage {

    package { 'marathon-java' :
      ensure   => $java_ensure,
      name     => $java_package,
      provider => $java_provider,
    }

    Package['marathon-java'] ~>
    Service <| title == 'marathon' |>

  }

}
