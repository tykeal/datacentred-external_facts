require 'spec_helper'
describe 'external_facts' do
  context 'FOSS < 4.0' do
    let(:facts) do
      {
        is_pe: false,
        puppetversion: '2.7.1'
      }
    end

    it { is_expected.to contain_class('external_facts') }
    it { is_expected.to contain_class('external_facts::params') }

    it {
      is_expected.to contain_file('facter basedir').with(
        'path' => '/etc/facter',
      )
    }
    it {
      is_expected.to contain_file('facts dir').with(
        'path'    => '/etc/facter/facts.d',
        'recurse' => true,
        'purge'   => true,
      )
    }
  end

  context 'FOSS >= 4.0' do
    let(:settings) do
      {
        environmentpath: '/etc/puppetlabs'
      }
    end
    let(:facts) do
      {
        is_pe: false,
        puppetversion: '4.2.1',
      }
    end

    it {
      is_expected.to contain_file('facter basedir').with(
        'path' => '/etc/puppetlabs/facter',
      )
    }
    it {
      is_expected.to contain_file('facts dir').with(
        'path'    => '/etc/puppetlabs/facter/facts.d',
        'recurse' => true,
        'purge'   => true,
      )
    }
  end

  context 'PE' do
    let(:settings) do
      {
        environmentpath: '/etc/puppetlabs'
      }
    end
    let(:facts) do
      {
        is_pe: true,
        pe_version: '3.8.1',
        puppetversion: '3.8.1 (Puppet Enterprise 3.8.1)',
      }
    end

    it {
      is_expected.to contain_file('facter basedir').with(
        'path' => '/etc/puppetlabs/facter',
      )
    }
    it {
      is_expected.to contain_file('facts dir').with(
        'path'    => '/etc/puppetlabs/facter/facts.d',
        'recurse' => true,
        'purge'   => true,
      )
    }
  end
end

# vim: ts=2 sw=2 sts=2 et :
