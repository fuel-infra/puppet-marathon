class marathon::params {
  $package_manage = true
  $package_ensure = 'present'
  $package_name = 'marathon'
  $package_provider = undef

  $service_enable = true
  $service_manage = true
  $service_name = 'marathon'
  $service_provider = undef

  $zk_servers = ['localhost']
  $zk_marathon_servers = undef
  $zk_mesos_path = 'mesos'
  $zk_marathon_path = 'marathon'
  $zk_default_port = '2181'

  $libprocess_ip = '127.0.0.1'

  $java_manage = false
  $java_package = 'openjdk-8-jre-headless'
  $java_ensure = 'present'
  $java_provider = undef
  $java_opts = '-Xmx512m'
  $java_home = undef

  $mesos_principal = undef
  $mesos_secret = undef
  $mesos_masters = 'http://localhost:5050'

  $secret_file_path = '/etc/marathon/auth_secret'

  $config_base_path = '/etc/marathon'
  $config_dir_path = '/etc/marathon/conf'
  $config_file_path = '/etc/default/marathon'
  $config_file_mode = '0640'

  $startup_manage = false
  $launcher_manage = false
  $launcher_path = '/usr/bin/marathon'

  $jar_file_path = '/usr/share/java/marathon-runnable.jar'

  $options = { }
}
