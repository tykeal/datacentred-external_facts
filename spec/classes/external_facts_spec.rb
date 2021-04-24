require 'spec_helper'
describe 'external_facts' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'default' do
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

      context 'with external_facts set' do
        let(:params) do
          {
            external_facts: {
              test1: {
                value: true,
              },
              test2: {
                value: 'testing',
              }
            }
          }
        end

        it { is_expected.to contain_external_facts__fact('test1') }
        it {
          is_expected.to contain_file('fact test1').with(
            'content' => 'test1=true',
          )
        }

        it { is_expected.to contain_external_facts__fact('test2') }
        it {
          is_expected.to contain_file('fact test2').with(
            'content' => 'test2=testing',
          )
        }
      end
    end
  end
end
