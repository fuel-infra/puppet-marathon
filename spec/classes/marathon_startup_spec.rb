require 'spec_helper'

describe 'marathon::startup' do
  context 'on the Ubuntu system' do
    let(:facts) do
      {
          :operatingsystem => 'Ubuntu',
      }
    end

    context 'with default parameters and startup_manage and launcher_manage enabled' do
      let(:params) do
        {
            :startup_manage => true,
            :launcher_manage => true,
        }
      end

      it { is_expected.to compile.with_all_deps }

      upstart_content =<<-eof
description "Marathon scheduler for Mesos"

start on runlevel [2345]
stop on runlevel [!2345]

respawn
respawn limit 10 5

exec /usr/bin/marathon --jar '/usr/share/java/marathon-runnable.jar'
      eof
      upstart_parameters = {
          :ensure => 'present',
          :owner => 'root',
          :group => 'root',
          :mode => '0644',
          :content => upstart_content,
      }

      it { is_expected.to contain_file('marathon_upstart_file').with(upstart_parameters) }

      init_parameters = {
          :ensure => 'symlink',
          :target => '/lib/init/upstart-job',
          :path => '/etc/init.d/marathon',
      }

      it { is_expected.to contain_file('marathon_init.d_wrapper').with(init_parameters) }

      launcher_parameters = {
          :ensure => 'present',
          :owner => 'root',
          :group => 'root',
          :mode => '0755',
          :path => '/usr/bin/marathon',
      }

      it { is_expected.to contain_file('marathon_launcher_file').with(launcher_parameters) }
    end

    context 'with custom parameters' do
      let(:params) do
        {
            :startup_manage => true,
            :launcher_manage => true,
            :launcher_path => '/usr/local/bin/marathon',
            :service_name => 'my-marathon',
            :jar_file_path => false,
        }
      end

      it { is_expected.to compile.with_all_deps }

      upstart_content =<<-eof
description "Marathon scheduler for Mesos"

start on runlevel [2345]
stop on runlevel [!2345]

respawn
respawn limit 10 5

exec /usr/local/bin/marathon
      eof
      upstart_parameters = {
          :ensure => 'present',
          :owner => 'root',
          :group => 'root',
          :mode => '0644',
          :content => upstart_content,
      }

      it { is_expected.to contain_file('marathon_upstart_file').with(upstart_parameters) }

      init_parameters = {
          :ensure => 'symlink',
          :target => '/lib/init/upstart-job',
          :path => '/etc/init.d/my-marathon',
      }

      it { is_expected.to contain_file('marathon_init.d_wrapper').with(init_parameters) }

      launcher_parameters = {
          :ensure => 'present',
          :owner => 'root',
          :group => 'root',
          :mode => '0755',
          :path => '/usr/local/bin/marathon',
      }

      it { is_expected.to contain_file('marathon_launcher_file').with(launcher_parameters) }
    end

    context 'with startup_manage disabled' do
      let(:params) do
        {
            :startup_manage => false,
        }
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.not_to contain_file('marathon_upstart_file') }

      it { is_expected.not_to contain_file('marathon_init.d_wrapper') }
    end

    context 'with launcher_manage disabled' do
      let(:params) do
        {
            :launcher_manage => false,
        }
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.not_to contain_file('marathon_launcher_file') }

    end
  end
end
