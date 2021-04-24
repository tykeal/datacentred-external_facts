require 'spec_helper'
describe 'external_facts::fact' do
  let(:title) { 'testing' }

  context 'with defaults for all parameters' do
    let(:params) do
      {}
    end

    it { is_expected.to contain_class('external_facts') }

    it {
      is_expected.to contain_file('fact testing').with(
        'ensure'  => 'file',
        'path'    => '/etc/puppetlabs/facter/facts.d/testing.txt',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
        'content' => 'testing=true',
      )
    }
  end
end
