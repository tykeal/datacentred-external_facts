require 'spec_helper'
describe 'external_facts' do
  context 'FOSS < 4.0' do
    let(:facts) {
      {
        :is_pe         => false,
        :puppetversion => '2.7.1'
      }
    }

    it { should contain_class('external_facts') }
    it { should contain_class('external_facts::params') }

    it { should contain_file('facter basedir').with(
      'path' => '/etc/facter',
    ) }
    it { should contain_file('facts dir').with(
      'path'    => '/etc/facter/facts.d',
      'recurse' => true,
      'purge'   => true,
    ) }
  end

  context 'FOSS >= 4.0' do
    let(:settings) {
      {
        :environmentpath => '/etc/puppetlabs'
      }
    }
    let(:facts) {
      {
        :is_pe         => false,
        :puppetversion => '4.2.1',
      }
    }

    it { should contain_file('facter basedir').with(
      'path' => '/etc/puppetlabs/facter',
    ) }
    it { should contain_file('facts dir').with(
      'path'    => '/etc/puppetlabs/facter/facts.d',
      'recurse' => true,
      'purge'   => true,
    ) }
  end

  context 'PE' do
    let(:settings) {
      {
        :environmentpath => '/etc/puppetlabs'
      }
    }
    let(:facts) {
      {
        :is_pe         => true,
        :pe_version    => '3.8.1',
        :puppetversion => '3.8.1 (Puppet Enterprise 3.8.1)',
      }
    }

    it { should contain_file('facter basedir').with(
      'path' => '/etc/puppetlabs/facter',
    ) }
    it { should contain_file('facts dir').with(
      'path'    => '/etc/puppetlabs/facter/facts.d',
      'recurse' => true,
      'purge'   => true,
    ) }
  end
end

# vim: ts=2 sw=2 sts=2 et :
