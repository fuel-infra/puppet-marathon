require 'spec_helper'

describe 'marathon::java' do
  context 'with default parameters and manage_java enabled' do
    let(:params) do
      {
          :java_manage => true,
      }
    end

    it { is_expected.to compile.with_all_deps }

    package_parameters = {
        :ensure => 'present',
        :name => 'openjdk-8-jre-headless',
    }
    it { is_expected.to contain_package('marathon-java').with(package_parameters) }
  end

  context 'with custom parameters' do
    let(:params) do
      {
          :java_manage => true,
          :java_ensure => 'latest',
          :java_package => 'my-java',
          :java_provider => 'pip',
      }
    end

    it { is_expected.to compile.with_all_deps }

    package_parameters = {
        :ensure => 'latest',
        :name => 'my-java',
        :provider => 'pip',
    }
    it { is_expected.to contain_package('marathon-java').with(package_parameters) }
  end

  context 'with java_manage disabled' do
    let(:params) do
      {
          :java_manage => false,
      }
    end

    it { is_expected.to compile.with_all_deps }

    it { is_expected.not_to contain_package('marathon-java') }
  end
end
