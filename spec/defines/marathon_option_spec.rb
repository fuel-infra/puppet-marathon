require 'spec_helper'

describe 'marathon::option', :type => :define do
  let(:title) { 'test' }

  context 'with default parameters' do
    let(:params) do
      {
          :value => '123',
      }
    end

    it 'contains the option file with correct content' do
      parameters = {
          :content => "123\n",
          :ensure => 'present',
          :owner => 'root',
          :group => 'root',
          :mode => '0640',
      }
      is_expected.to contain_file('marathon-option-test').with(parameters)
    end
  end

  context 'with non-default parameters' do
    let(:params) do
      {
          :value => '321',
          :ensure => 'absent',
          :owner => 'user',
          :group => 'group',
          :mode => '0755',
      }
    end

    it 'contains the option file with correct content' do
      parameters = {
          :content => "321\n",
          :ensure => 'absent',
          :owner => 'user',
          :group => 'group',
          :mode => '0755',
      }
      is_expected.to contain_file('marathon-option-test').with(parameters)
    end
  end

  context 'with undefined value' do
    it { is_expected.to contain_file('marathon-option-test').with(:content => "\n") }
  end
end
