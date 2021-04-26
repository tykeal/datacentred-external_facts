require 'spec_helper'
describe 'external_facts::fact' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
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

      context 'with string for value' do
        let(:params) do
          {
            value: 'testing',
          }
        end

        it {
          is_expected.to contain_file('fact testing').with(
            'content' => 'testing=testing',
          )
        }
      end
    end
  end
end
