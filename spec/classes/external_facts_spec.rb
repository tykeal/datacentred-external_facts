require 'spec_helper'
describe 'external_facts' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
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
end
