require 'spec_helper'
describe 'external_facts' do
  context 'FOSS >= 4.0' do
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
