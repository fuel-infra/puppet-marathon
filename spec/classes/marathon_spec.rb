require 'spec_helper'

describe 'marathon' do
  context 'with default parameters' do
    config_parameters = {
        :zk_servers => ['localhost'],
        :zk_mesos_path => 'mesos',
        :zk_marathon_path => 'marathon',
        :zk_default_port => '2181',
        :libprocess_ip => '127.0.0.1',
        :mesos_masters => 'http://localhost:5050',
        :secret_file_path => '/etc/marathon/auth_secret',
        :config_base_path => '/etc/marathon',
        :config_dir_path => '/etc/marathon/conf',
        :config_file_path => '/etc/default/marathon',
        :config_file_mode => '0640',
        :java_opts => '-Xmx512m',
        :options => {},
    }

    install_parameters = {
        :package_manage => true,
        :package_name => 'marathon',
        :package_ensure => 'present',
    }

    java_parameters = {
        :java_manage => false,
        :java_package => 'openjdk-8-jre-headless',
        :java_ensure => 'present',
    }

    service_parameters = {
        :service_name => 'marathon',
        :service_manage => true,
        :service_enable => true,
    }

    startup_parameters = {
        :startup_manage => false,
        :launcher_manage => false,
        :launcher_path => '/usr/bin/marathon',
        :jar_file_path => '/usr/share/java/marathon-runnable.jar',
        :service_name => 'marathon',
    }

    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('marathon::config').with(config_parameters) }

    it { is_expected.to contain_class('marathon::install').with(install_parameters) }

    it { is_expected.to contain_class('marathon::java').with(java_parameters) }

    it { is_expected.to contain_class('marathon::service').with(service_parameters) }

    it { is_expected.to contain_class('marathon::startup').with(startup_parameters) }
  end

  context 'with custom parameters' do
    let(:params) do
      {
          :package_ensure => 'latest',
          :package_name => 'my-marathon',
          :package_manage => false,
          :package_provider => 'pip',
          :service_enable => false,
          :service_manage => false,
          :service_name => 'my-marathon',
          :service_provider => 'systemd',
          :java_manage => true,
          :java_package => 'my-java',
          :java_ensure => 'latest',
          :java_provider => 'pip',
          :launcher_manage => true,
          :launcher_path => '/usr/local/bin/marathon',
          :startup_manage => true,
          :jar_file_path => '/usr/share/java/my-marathon.jar',
          :zk_servers => ['zk1'],
          :zk_marathon_servers => ['zk2'],
          :zk_mesos_path => 'my-mesos',
          :zk_marathon_path => 'my-marathon',
          :zk_default_port => '2182',
          :libprocess_ip => '192.168.0.1',
          :mesos_principal => 'admin',
          :mesos_secret => 'secret',
          :mesos_masters => 'http://zk2:50500',
          :secret_file_path => '/usr/local/etc/marathon/auth_secret',
          :config_base_path => '/usr/local/etc/marathon',
          :config_dir_path => '/usr/local/etc/marathon/conf',
          :config_file_path => '/etc/default/my-marathon',
          :config_file_mode => '0600',
          :java_opts => '-Xmx1024m',
          :java_home => '/usr/local/java',
          :options => {
              'event_subscriber' => 'http_callback',
          }
      }
    end

    config_parameters = {
        :zk_servers => ['zk1'],
        :zk_marathon_servers => ['zk2'],
        :zk_mesos_path => 'my-mesos',
        :zk_marathon_path => 'my-marathon',
        :zk_default_port => '2182',
        :libprocess_ip => '192.168.0.1',
        :mesos_principal => 'admin',
        :mesos_secret => 'secret',
        :mesos_masters => 'http://zk2:50500',
        :secret_file_path => '/usr/local/etc/marathon/auth_secret',
        :config_base_path => '/usr/local/etc/marathon',
        :config_dir_path => '/usr/local/etc/marathon/conf',
        :config_file_path => '/etc/default/my-marathon',
        :config_file_mode => '0600',
        :java_opts => '-Xmx1024m',
        :java_home => '/usr/local/java',
        :options => {
            'event_subscriber' => 'http_callback',
        },
    }

    install_parameters = {
        :package_manage => false,
        :package_name => 'my-marathon',
        :package_ensure => 'latest',
        :package_provider => 'pip',
    }

    java_parameters = {
        :java_manage => true,
        :java_package => 'my-java',
        :java_ensure => 'latest',
        :java_provider => 'pip',
    }

    service_parameters = {
        :service_name => 'my-marathon',
        :service_manage => false,
        :service_enable => false,
        :service_provider => 'systemd',
    }

    startup_parameters = {
        :startup_manage => true,
        :launcher_manage => true,
        :launcher_path => '/usr/local/bin/marathon',
        :jar_file_path => '/usr/share/java/my-marathon.jar',
        :service_name => 'my-marathon',
    }

    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('marathon::config').with(config_parameters) }

    it { is_expected.to contain_class('marathon::install').with(install_parameters) }

    it { is_expected.to contain_class('marathon::java').with(java_parameters) }

    it { is_expected.to contain_class('marathon::service').with(service_parameters) }

    it { is_expected.to contain_class('marathon::startup').with(startup_parameters) }
  end
end
